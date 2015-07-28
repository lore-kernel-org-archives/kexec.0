Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZK00v-00068V-UD
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 08:13:34 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Enable compressed dump formats for Xen
Date: Tue, 28 Jul 2015 08:12:02 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DD2A68@BPXM01GP.gisp.nec.co.jp>
References: <20150723124321.7d8406c0@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DD2A05@BPXM01GP.gisp.nec.co.jp>
 <20150728095953.6c142dd5@hananiah.suse.cz>
In-Reply-To: <20150728095953.6c142dd5@hananiah.suse.cz>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> Hello Petr,
>>
>> >Hello all,
>> >
>> >this patch enables compressed file formats for Xen. I was suprized
>> >that nobody noticed earlier, given how trivial the change is. ;-)
>>
>> Good catch.
>> Since there is no Xen dump in the kdump-compressed format, is it also
>> necessary to fix the crash ?
>
>Yes, I have a patch set for crash, but I wanted to make sure the change
>gets accepted in makedumpfile first. The crash patch set is rather
>intrusive; if makedumpfile can actually produce such files, it makes it
>easier for me to negotiate with Dave Anderson. ;-)

I see, I think it's a good approach.

>> BTW, I think we should fix the manuals as well. There are some wrong
>> statements "-E option must be specified with this option" and
>> some examples implicate that -E option is necessary to Xen dump.
>
>Good point. Should I send it as a separate patch, or include it in a
>patch set and resend?

I prefer a separate patch, but I don't mind either way.


Thanks
Atsushi Kumagai

>Petr T
>
>> Thanks
>> Atsushi Kumagai
>>
>> >Originally, the compressed KDUMP format was not sufficient for Xen
>> >Dom0 dumps, because it did not contain required Xen-specific
>> >information. However, all this info is stored in ELF notes, which
>> >have been present in the compressed file since version 4, so there
>> >is no longer any reason to restrict Xen dumps to ELF only.
>> >
>> >One minor fix is necessary. In a Xen dump, PFN refers to physical
>> >pages _inside_ Dom0, but when compressing the whole file, the machine
>> >pages are used in fact (although the variable is still called pfn).
>> >Consequently, readmem() must interpret the address as a machine
>> >address rather than Dom0 physical address when saving Xen files.
>> >
>> >Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>> >
>> >diff --git a/makedumpfile.c b/makedumpfile.c
>> >index de40932..2636036 100644
>> >--- a/makedumpfile.c
>> >+++ b/makedumpfile.c
>> >@@ -6015,9 +6015,11 @@ int
>> > read_pfn(mdf_pfn_t pfn, unsigned char *buf)
>> > {
>> > 	unsigned long long paddr;
>> >+	int type_addr;
>> >
>> > 	paddr = pfn_to_paddr(pfn);
>> >-	if (!readmem(PADDR, paddr, buf, info->page_size)) {
>> >+	type_addr = is_xen_memory() ? MADDR_XEN : PADDR;
>> >+	if (!readmem(type_addr, paddr, buf, info->page_size)) {
>> > 		ERRMSG("Can't get the page data.\n");
>> > 		return FALSE;
>> > 	}
>> >@@ -7654,12 +7656,6 @@ initial_xen(void)
>> > 	MSG("Xen is not supported on powerpc.\n");
>> > 	return FALSE;
>> > #else
>> >-	if(!info->flag_elf_dumpfile && !info->flag_dmesg) {
>> >-		MSG("Specify '-E' option for Xen.\n");
>> >-		MSG("Commandline parameter is invalid.\n");
>> >-		MSG("Try `makedumpfile --help' for more
>> >information.\n");
>> >-		return FALSE;
>> >-	}
>> > #ifndef __x86_64__
>> > 	if (DL_EXCLUDE_ZERO < info->max_dump_level) {
>> > 		MSG("Dump_level is invalid. It should be 0 or
>> > 1.\n");
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
