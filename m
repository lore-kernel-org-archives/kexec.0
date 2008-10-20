Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KroNQ-0000kI-Ql
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 06:36:29 +0000
Received: from G3W0631.americas.hpqcorp.net (g3w0631.americas.hpqcorp.net
	[16.233.59.15]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g1t0026.austin.hp.com (Postfix) with ESMTPS id ED937C6F2
	for <kexec@lists.infradead.org>; Mon, 20 Oct 2008 06:36:02 +0000 (UTC)
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Mon, 20 Oct 2008 06:35:58 +0000
Subject: RE: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
Message-ID: <28113A0489833849A1CF9EC16F421543464A5A7102@GVW1097EXB.americas.hpqcorp.net>
References: <964791790.1610871224266288310.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>,
	<1101712308.1611161224266316866.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1101712308.1611161224266316866.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>

>> Well, without following the thread, I had a similar error and in my
>> case it was that PAE was missing in the capture kernel. That's why I
>> asked. I think that is wrong here, but I still wanted to mention that
>> case (and I don't have time to read all the mails related to that topic
>> in the crash mailing list, sorry).
>>
>> Regards,
>> Bernhard

>Well that makes perfect sense -- the upper bit gets stripped in
>the 32-bit PTE and the wrong location gets mapped.  I was looking
>at the fs/vmcore.c code for something to that effect, and I just
>presumed his capture kernel was PAE.  Looking back at the thread,
>the only thing I see is this:
>
>  "my "capture kernel" is just the standard Ubuntu kernel
>   (with 1G kernel / 3G user)."
>
>Whatever that means...
>
>So Kevin, that's the first thing to check.
>
>Thanks Bernhard,
>  Dave



Dave,

Thanks for responding in my absence- was in las vegas this weekend, which is no place to coherently answer emails :)


Bernhard,

My capture kernel in fact does NOT have PAE enabled. The Ubuntu 2.6.20 "generic" kernel has HIGHMEM4G set and no PAE. This sounds like a plausible cause of problems. However, as I mentioned, I cannot seem to boot a kernel that has HIGHMEM64G enabled, as it seems to go into an infinite loop with the message "bad: scheduling from the idle thread!" (full backtrace shown in my original email http://lists.infradead.org/pipermail/kexec/2008-October/002748.html ).

This is why I started using the Ubuntu "generic" kernel in the first place instead of re-using the same kernel for both regular use and dump capture. I had thought the "bad: scheduling..." message was due to my VMSPLIT being modified, but it turned out that HIGHMEM64G seemed to be the culprit because the modified VMSPLIT with HIGHMEM4G booted into the capture kernel just fine.

Any suggestions on the error? Is it actually fatal? The text scrolls by so fast that I'm not sure if things are actually happening on the system or it's stuck in some loop doing nothing- the hard drive light doesn't really seem to turn on (and while copying a 4GB crash dump it should be on for at least a little bit).

-Kevin


For reference (and to avoid digging) here is the diff of my kernel against the Ubuntu "generic" kernel.

diff /boot/config-2.6.20-17-generic /boot/config-2.6.20-17.39-custom2
3,4c3,4
< # Linux kernel version: 2.6.20-17-generic
< # Wed Aug 20 14:43:36 2008
---
> # Linux kernel version: 2.6.20-17.37-custom2
> # Tue Aug 19 18:50:53 2008
33c33
< CONFIG_VERSION_SIGNATURE="Ubuntu 2.6.20-17.39-generic"
---
> CONFIG_VERSION_SIGNATURE="Ubuntu 2.6.20-17.39-generic"
51c51
< # CONFIG_EMBEDDED is not set
---
> CONFIG_EMBEDDED=y
188,190c188,194
< CONFIG_HIGHMEM4G=y
< # CONFIG_HIGHMEM64G is not set
< CONFIG_PAGE_OFFSET=0xC0000000
---
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> # CONFIG_VMSPLIT_3G is not set
> # CONFIG_VMSPLIT_3G_OPT is not set
> # CONFIG_VMSPLIT_2G is not set
> CONFIG_VMSPLIT_1G=y
> CONFIG_PAGE_OFFSET=0x40000000
191a196
> CONFIG_X86_PAE=y
204c209
< # CONFIG_RESOURCES_64BIT is not set
---
> CONFIG_RESOURCES_64BIT=y
1161a1167
> CONFIG_IDE_MAX_HWIFS=4
1443a1450
> # CONFIG_PATA_PLATFORM is not set
1525a1533
> CONFIG_I2O_EXT_ADAPTEC_DMA64=y


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
