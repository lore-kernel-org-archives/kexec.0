Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dE5KY-0002Xv-J9
 for kexec@lists.infradead.org; Fri, 26 May 2017 02:50:24 +0000
Received: by mail-pf0-f182.google.com with SMTP id e193so184210630pfh.0
 for <kexec@lists.infradead.org>; Thu, 25 May 2017 19:50:01 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH v3 1/2] makedumpfile: add runtime kaslr
 offset if it exists
References: <cover.1495619809.git.panand@redhat.com>
 <a2b4fcdf5974e6ea8b66abade20fb2ae1ab9ae08.1495619809.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDACC2@BPXM01GP.gisp.nec.co.jp>
 <a0f93c46-4ca3-cfc7-e2bf-b0059bd8fdea@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDB285@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <99eb6e19-2d58-2118-ddde-3d6b8d282554@redhat.com>
Date: Fri, 26 May 2017 08:19:56 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDB285@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "xlpang@redhat.com" <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>



On Friday 26 May 2017 07:17 AM, Atsushi Kumagai wrote:
>>>> write_vmcoreinfo_data(void)
>>>> {
>>>> 	/*
>>>> +	 * write 1st kernel's KERNELOFFSET
>>>> +	 */
>>>> +	if (info->kaslr_offset)
>>>> +		fprintf(info->file_vmcoreinfo, "%s%lx\n", STR_KERNELOFFSET,
>>>> +		    info->kaslr_offset);
>>> When will this data written to VMCOREINFO file be used ?
>>> info->kaslr_offset is necessary for vmlinux but -x and -i are exclusive.
>> This is what I thought:
>>
>> Lets says we have got a vmcore1 after re-filtering original vmcore. Now, if we
>> would like to re-filter vmcore1 then we will need kaslr_offset again. So,
>> should we not right kaslr_offset in vmcoreinfo of vmcore1 as well?
> write_vmcoreinfo_data() is called only for -g option, it makes a
> VMCOREINFO file as a separate file, it doesn't overwrite VMCOREINFO in vmcore.

OK..got it.

Will remove this function and send v4.


Thanks

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
