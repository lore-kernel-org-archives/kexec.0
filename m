Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anN3R-0002wl-Nk
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 09:13:46 +0000
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 10:13:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 789C4219004D
 for <kexec@lists.infradead.org>; Tue,  5 Apr 2016 10:12:59 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u359DJdV8258014
 for <kexec@lists.infradead.org>; Tue, 5 Apr 2016 09:13:19 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u358DKrc012513
 for <kexec@lists.infradead.org>; Tue, 5 Apr 2016 02:13:21 -0600
Date: Tue, 5 Apr 2016 11:13:16 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] s390/kexec: Consolidate
 crash_map/unmap_reserved_pages() and
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160405111316.2fa4772c@holzheu>
In-Reply-To: <1459840199-19920-1-git-send-email-xlpang@redhat.com>
References: <1459840199-19920-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Minfei Huang <mhuang@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hello Xunlei,

On Tue,  5 Apr 2016 15:09:59 +0800
Xunlei Pang <xlpang@redhat.com> wrote:
> Commit 3f625002581b ("kexec: introduce a protection mechanism
> for the crashkernel reserved memory") is a similar mechanism
> for protecting the crash kernel reserved memory to previous
> crash_map/unmap_reserved_pages() implementation, the new one
> is more generic in name and cleaner in code (besides, some
> arch may not be allowed to unmap the pgtable).
> 
> Therefore, this patch consolidates them, and uses the new
> arch_kexec_protect(unprotect)_crashkres() to replace former
> crash_map/unmap_reserved_pages() which by now has been only
> used by S390.
> 
> The consolidation work needs the crash memory to be mapped
> initially, so get rid of S390 crash kernel memblock removal
> in reserve_crashkernel().

If you fix this comment, I am fine with your patch.

Acked-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
