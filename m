Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bO4Qb-00014N-5Z
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 14:49:21 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
References: <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
Subject: Re: [V2][PATCH 1/2] PKCS#7: Fix kernel panic when referring to the
 empty AuthorityKeyIdentifier
MIME-Version: 1.0
Content-ID: <3759.1468594137.1@warthog.procyon.org.uk>
Date: Fri, 15 Jul 2016 15:48:57 +0100
Message-ID: <3760.1468594137@warthog.procyon.org.uk>
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

> This fix resolves the following kernel panic if the empty
> AuthorityKeyIdentifier employed.

It should be noted that this is only an issue if DEBUG is #defined at the top
of pkcs7_verify.c as the crash happens in a pr_debug() statement.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
