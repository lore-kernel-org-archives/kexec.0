Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3yxQ-0000zC-Kt
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 06:00:46 +0000
Received: by mail-pg0-f53.google.com with SMTP id v1so9627230pgv.1
 for <kexec@lists.infradead.org>; Thu, 27 Apr 2017 23:00:22 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH 1/2] makedumpfile: add runtime kaslr offset
 if it exists
References: <cover.1493272570.git.panand@redhat.com>
 <11497aba9c2a9f6441bb7ee874e9cba70b02c7f1.1493272570.git.panand@redhat.com>
 <5902D5E0.809@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <a9e8d087-5e7d-2a29-92cf-59e145f6c79a@redhat.com>
Date: Fri, 28 Apr 2017 11:30:17 +0530
MIME-Version: 1.0
In-Reply-To: <5902D5E0.809@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xlpang@redhat.com, ats-kumagai@wm.jp.nec.com
Cc: keescook@chromium.org, bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, yinghai@kernel.org, mingo@kernel.org



On Friday 28 April 2017 11:10 AM, Xunlei Pang wrote:
>> +	 */
>> +	get_kaslr_offset(SYMBOL(_stext));
> Looks like acquiring "KERNELOFFSET" in read_vmcoreinfo() should be enough here.

Ah..OK..but may be not here..rather in get_kaslr_offset_x86_64() would be 
better. Not all arch could export this offset.

>
> We can get kaslr offset directly from the vmcoreinfo because the compressed dumpfile
> contains vmcoreinfo as well in case of flag_refiltering, also x86_64 kernel has exported
> "vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());"


~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
