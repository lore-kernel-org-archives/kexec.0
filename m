Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEy2G-0008PQ-IR
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 06:15:44 +0000
Date: Wed, 27 Apr 2011 15:15:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: remove duplicated backup_src_start field from
	struct crash_elf_info
Message-ID: <20110427061535.GE14497@verge.net.au>
References: <1303875207-9273-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303875207-9273-1-git-send-email-amwang@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Apr 27, 2011 at 11:33:27AM +0800, Amerigo Wang wrote:
> Vivek pointed out that we have duplicated ->backup_src_start
> in struct crash_elf_info and struct kexec_info.
> 
> This patch removes the ->backup_src_start and ->backup_src_end
> from struct crash_elf_info.
> 
> I tested it on both i686 and ppc64, and used a test case from
> Dave Anderson to confirm the backup region is correct on i686.
> 
> Signed-off-by: WANG Cong <amwang@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Simon Horman <horms@verge.net.au>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
