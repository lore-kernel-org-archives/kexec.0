Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvdAe-0000wP-01
 for kexec@lists.infradead.org; Thu, 08 Aug 2019 07:49:13 +0000
Date: Thu, 8 Aug 2019 15:49:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190808074904.GA5300@dhcp-128-65.nay.redhat.com>
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matthew Garrett <matthewgarrett@google.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-efi <linux-efi@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08/05/19 at 06:55pm, Ard Biesheuvel wrote:
> On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung@redhat.com> wrote:
> >
> > kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> > just reset while calling efi_delete_dummy_variable();  Unfortunately
> > I don't know how to debug the firmware, it is also possible a potential
> > problem on real hardware as well although nobody reproduced it.
> >
> > The intention of efi_delete_dummy_variable is to trigger garbage collection
> > when entering virtual mode.  But SetVirtualAddressMap can only run once
> > for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> > a good place to clean dummy object.
> >
> 
> I would argue that this means it is not a good place to *create* the
> dummy variable, and if we don't create it, we don't have to delete it
> either.
> 
> > Drop efi_delete_dummy_variable so that kexec reboot can work.
> >
> 
> Creating it and not deleting it is bad, so please try and see if we
> can omit the creation on this code path instead.
> 

Check the code for the dummy var, it is created only in below chunk:
arch/x86/platform/efi/quirks.c:
efi_query_variable_store():
[snip]
	/*
	 * We account for that by refusing the write if permitting it would
	 * reduce the available space to under 5KB. This figure was provided by
	 * Samsung, so should be safe.
	 */
	if ((remaining_size - size < EFI_MIN_RESERVE) &&
		!efi_no_storage_paranoia) {

		/*
		 * Triggering garbage collection may require that the firmware
		 * generate a real EFI_OUT_OF_RESOURCES error. We can force
		 * that by attempting to use more space than is available.
		 */
		unsigned long dummy_size = remaining_size + 1024;
		void *dummy = kzalloc(dummy_size, GFP_KERNEL);

		if (!dummy)
			return EFI_OUT_OF_RESOURCES;

		status = efi.set_variable((efi_char16_t *)efi_dummy_name,
					  &EFI_DUMMY_GUID,
					  EFI_VARIABLE_NON_VOLATILE |
					  EFI_VARIABLE_BOOTSERVICE_ACCESS |
					  EFI_VARIABLE_RUNTIME_ACCESS,
					  dummy_size, dummy);

		if (status == EFI_SUCCESS) {
			/*
			 * This should have failed, so if it didn't make sure
			 * that we delete it...
			 */
			efi_delete_dummy_variable();
		}

[snip]

So the dummy var only be created when the if condition matched, also
once creating succeeded it is deleted.  The deleting while entering
virtual mode is always deleting a non exist efi var.  Please correct me
if I miss something. 

If above is true, then at least in the kexec path can be dropped because
we have a real bug which resets machine.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
