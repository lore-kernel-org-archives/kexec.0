Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJsF-0008OP-4K
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 13:06:51 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1468399874-5880-2-git-send-email-jia.zhang@windriver.com>
References: <1468399874-5880-2-git-send-email-jia.zhang@windriver.com>
 <1468399874-5880-1-git-send-email-jia.zhang@windriver.com>
Subject: Re: [PATCH 2/2] pefile: Fix the failure of calculation for digest
MIME-Version: 1.0
Content-ID: <4332.1468415184.1@warthog.procyon.org.uk>
Date: Wed, 13 Jul 2016 14:06:24 +0100
Message-ID: <4333.1468415184@warthog.procyon.org.uk>
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
To: Lans Zhang <jia.zhang@windriver.com>
Cc: dhowells@redhat.com, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com

Lans Zhang <jia.zhang@windriver.com> wrote:

> The commit e68503bd forgot to set digest_len and thus cause the following
> error reported by kexec when launching a crash kernel:
> "kexec_file_load failed: Bad message"

You need to put the commit ID in a "Fixes:" line as per SubmittingPatches.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
