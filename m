Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxUyL-00011L-Bf
 for kexec@lists.infradead.org; Tue, 13 Aug 2019 11:28:16 +0000
Subject: Re: [PATCH] do not clean dummy variable in kexec path
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
Date: Tue, 13 Aug 2019 13:28:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg59@google.com>
Cc: kexec devel list <kexec@lists.infradead.org>

On 08/05/19 17:55, ard.biesheuvel at linaro.org (Ard Biesheuvel) wrote:
> On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung at redhat.com> wrote:
>>
>> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
>> just reset while calling efi_delete_dummy_variable();  Unfortunately
>> I don't know how to debug the firmware, it is also possible a
>> potential problem on real hardware as well although nobody reproduced
>> it.
>>
>> The intention of efi_delete_dummy_variable is to trigger garbage
>> collection when entering virtual mode.  But SetVirtualAddressMap can
>> only run once for each physical reboot, thus kexec_enter_virtual_mode
>> is not necessarily a good place to clean dummy object.
>>
>
> I would argue that this means it is not a good place to *create* the
> dummy variable, and if we don't create it, we don't have to delete it
> either.
>
>> Drop efi_delete_dummy_variable so that kexec reboot can work.
>>
>
> Creating it and not deleting it is bad, so please try and see if we
> can omit the creation on this code path instead.

The existent code seems to date back to the following upstream bug
report:

  https://bugzilla.kernel.org/show_bug.cgi?id=55471

The following commits appear relevant:

[1] 68d929862e29 ("efi: be more paranoid about available space when
    creating variables", 2013-03-06) -- part of v3.9-rc2

[2] cc5a080c5d40 ("efi: Pass boot services variable info to runtime
    code", 2013-04-15) -- part of v3.9-rc8

[3] 31ff2f20d900 ("efi: Distinguish between "remaining space" and
    actually used space", 2013-04-15) -- direct descendant of
    cc5a080c5d40, hence also part of v3.9-rc8

[4] f8b8404337de ("Modify UEFI anti-bricking code", 2013-06-10) -- part
    of v3.10-rc6

Commit [1] correctly observed that a varstore reclaim doesn't occur
after ExitBootServices() -- see an excerpt of the message, rewrapped for
readability, below:

> UEFI variables are typically stored in flash. For various reasons,
> avaiable space is typically not reclaimed immediately upon the
> deletion of a variable - instead, the system will garbage collect
> during initialisation after a reboot.

(I verified yesterday, using the edk2 source code, that there is no
varstore reclaim after ExitBootServices(), indeed.)

Thus, (it had been known that,) creating a non-volatile UEFI variable,
and then deleting it too, would not trigger a reclaim *at once*. After
the dummy creation/deletion, a cold reboot of the machine would still be
necessary.


Then looking at commit [4], I guess the idea was to trip the "high water
mark", in order to force a reclaim, with the following considerations:

- the high water mark should be tripped as early as possible, and as
  conservatively as possible, to avoid causing problems for the platform
  firmware,

- but the reclaim would still only occur at *next cold boot*.

In that regard, commit [4] looks justified to me.


However, there are two things in [4] that confuse me:

(a) Attempting to delete the dummy variable in efi_enter_virtual_mode().

(b) The following part, in efi_query_variable_store():

+               /*
+                * The runtime code may now have triggered a garbage collection
+                * run, so check the variable info again
+                */

Let me start with (b). That code is essentially dead, I would say, based
on the information that had already been captured in the commit message
of [1]. Reclaim would never happen after ExitBootServices(). (I assume
efi_query_variable_store() is only invoked after ExitBootServices(),
i.e., from kernel space proper -- sorry if that's a wrong assumption.)

Either way, (b) doesn't hurt; even if it's dead code on a specific
firmware platform, it shouldn't cause problems.


Considering (a): what justified the attempt to delete the dummy variable
in efi_enter_virtual_mode(), in commit [4]? Was that meant as a
fail-safe just so we don't leave a dummy variable lying around?

Because, that hunk in efi_enter_virtual_mode(), from [4], is where the
current trouble originates from. The function efi_enter_virtual_mode()
got split in two later, namely in:

[5] fabb37c736f9 ("x86/efi: Split efi_enter_virtual_mode", 2014-03-04)
    -- part of v3.15-rc1

and the "clean DUMMY object" logic was diligently copied to the new
function called kexec_enter_virtual_mode().

However, commit [5] did not *introduce* the cleanup logic specifically
for kexec. The cleanup hunk from commit [4] had never been conditional
on (!efi_setup). Therefore commit [5] only preserved the kexec behavior,
when it duplicated the cleanup to kexec_enter_virtual_mode().

So even if we consider the "clean DUMMY object" hunk from [4] a
justified fail-safe for the normal boot path, it doesn't apply to the
kexec path -- the cold-booted primary kernel will have gone through
those motions already, will it not?

Therefore, we should do two things:

- Remove the cleanup from the kexec path -- the cleanup logic from [4],
  even if justified for the cold boot path, should have never modified
  the kexec path.

- Consider moving the cleanup even for cold boot to a different spot.
  I'd argue for efi_query_variable_store() -- we should delete the dummy
  variable there, *regardless* of whether we just created it, or it had
  existed previously.

I think the present patch is certainly an improvement (it covers the
first item), as long as we explain in the commit message that [4] should
have restricted, as a minimum, the cleanup logic to the cold boot path.
In that case, the cleanup wouldn't have been explicitly duplicated for
kexec_enter_virtual_mode() in [5], and now it wouldn't be blowing up.


Regarding the particulars of the crash -- I've given some firmware
debugging hints in
<https://bugzilla.redhat.com/show_bug.cgi?id=1707669>, as I don't have
time to track that down myself. (Even this email is quite
extra-curricular for me.)

(Note: I'm not subscribed to the kexec list, so please CC me if you'd
like me to see your followup.)

Thanks
Laszlo


>> Signed-off-by: Dave Young <dyoung at redhat.com>
>> ---
>>  arch/x86/platform/efi/efi.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> --- linux-x86.orig/arch/x86/platform/efi/efi.c
>> +++ linux-x86/arch/x86/platform/efi/efi.c
>> @@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
>>
>>         if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
>>                 runtime_code_page_mkexec();
>> -
>> -       /* clean DUMMY object */
>> -       efi_delete_dummy_variable();
>>  #endif
>>  }
>>
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
