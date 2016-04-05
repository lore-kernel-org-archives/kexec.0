Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anO9M-000197-U9
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 10:23:57 +0000
Subject: Re: [PATCH v2] s390/kexec: Consolidate
 crash_map/unmap_reserved_pages() and
 arch_kexec_protect(unprotect)_crashkres()
References: <1459840199-19920-1-git-send-email-xlpang@redhat.com>
 <20160405111316.2fa4772c@holzheu>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <57039223.7020903@redhat.com>
Date: Tue, 5 Apr 2016 18:23:31 +0800
MIME-Version: 1.0
In-Reply-To: <20160405111316.2fa4772c@holzheu>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, Minfei Huang <mhuang@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On 2016/04/05 at 17:13, Michael Holzheu wrote:
> Hello Xunlei,
>
> On Tue,  5 Apr 2016 15:09:59 +0800
> Xunlei Pang <xlpang@redhat.com> wrote:
>> Commit 3f625002581b ("kexec: introduce a protection mechanism
>> for the crashkernel reserved memory") is a similar mechanism
>> for protecting the crash kernel reserved memory to previous
>> crash_map/unmap_reserved_pages() implementation, the new one
>> is more generic in name and cleaner in code (besides, some
>> arch may not be allowed to unmap the pgtable).
>>
>> Therefore, this patch consolidates them, and uses the new
>> arch_kexec_protect(unprotect)_crashkres() to replace former
>> crash_map/unmap_reserved_pages() which by now has been only
>> used by S390.
>>
>> The consolidation work needs the crash memory to be mapped
>> initially, so get rid of S390 crash kernel memblock removal
>> in reserve_crashkernel().

Oops, the final paragraph of the changelog should be changed to:
The consolidation work needs the crash memory to be mapped
initially, this is done in machine_kdump_pm_init() which is run
after reserve_crashkernel(). Once kdump kernel is loaded, the
new arch_kexec_protect_crashkres() implemented for S390 will
actually unmap the pgtable like before.

> If you fix this comment, I am fine with your patch.
>
> Acked-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>

Thanks,
Xunlei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
