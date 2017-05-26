Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dE4YP-0001JD-6h
 for kexec@lists.infradead.org; Fri, 26 May 2017 02:00:39 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH v3 1/2] makedumpfile: add runtime kaslr
 offset if it exists
Date: Fri, 26 May 2017 01:47:28 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDB285@BPXM01GP.gisp.nec.co.jp>
References: <cover.1495619809.git.panand@redhat.com>
 <a2b4fcdf5974e6ea8b66abade20fb2ae1ab9ae08.1495619809.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDACC2@BPXM01GP.gisp.nec.co.jp>
 <a0f93c46-4ca3-cfc7-e2bf-b0059bd8fdea@redhat.com>
In-Reply-To: <a0f93c46-4ca3-cfc7-e2bf-b0059bd8fdea@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "xlpang@redhat.com" <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index 301772a8820c..4986d098d69a 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -2099,6 +2099,13 @@ void
>>> write_vmcoreinfo_data(void)
>>> {
>>> 	/*
>>> +	 * write 1st kernel's KERNELOFFSET
>>> +	 */
>>> +	if (info->kaslr_offset)
>>> +		fprintf(info->file_vmcoreinfo, "%s%lx\n", STR_KERNELOFFSET,
>>> +		    info->kaslr_offset);
>>
>> When will this data written to VMCOREINFO file be used ?
>> info->kaslr_offset is necessary for vmlinux but -x and -i are exclusive.
>
>This is what I thought:
>
>Lets says we have got a vmcore1 after re-filtering original vmcore. Now, if we
>would like to re-filter vmcore1 then we will need kaslr_offset again. So,
>should we not right kaslr_offset in vmcoreinfo of vmcore1 as well?

write_vmcoreinfo_data() is called only for -g option, it makes a
VMCOREINFO file as a separate file, it doesn't overwrite VMCOREINFO in vmcore.

  if (info->flag_generate_vmcoreinfo)
    generate_vmcoreinfo()
      + write_vmcoreinfo_data()

find_kaslr_offsets() doesn't refer to the separate VMCOREINFO file,
writing STR_KERNELOFFSET in it is meaningless.


Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
