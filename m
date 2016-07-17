Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bOv1e-0000jC-IB
 for kexec@lists.infradead.org; Sun, 17 Jul 2016 22:59:07 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <57898E6A.5080101@windriver.com>
References: <57898E6A.5080101@windriver.com>
 <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
 <3760.1468594137@warthog.procyon.org.uk>
Subject: Re: [V2][PATCH 1/2] PKCS#7: Fix kernel panic when referring to the
 empty AuthorityKeyIdentifier
MIME-Version: 1.0
Content-ID: <31799.1468796321.1@warthog.procyon.org.uk>
Date: Sun, 17 Jul 2016 23:58:41 +0100
Message-ID: <31800.1468796321@warthog.procyon.org.uk>
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
Cc: dhowells@redhat.com, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, linux-crypto@vger.kernel.org

Lans Zhang <jia.zhang@windriver.com> wrote:

> Let me know if I need to add this comment to commit header.

I've done that.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
