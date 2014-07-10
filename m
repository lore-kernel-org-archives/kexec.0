Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X5L6X-0004iM-Fh
 for kexec@lists.infradead.org; Thu, 10 Jul 2014 20:38:10 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <42827.1405012013@turing-police.cc.vt.edu>
References: <42827.1405012013@turing-police.cc.vt.edu>
 <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
 <20140709151604.23074.4848.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH06/17] PKCS#7: Verify internal certificate chain
MIME-Version: 1.0
Content-ID: <30204.1405024657.1@warthog.procyon.org.uk>
Date: Thu, 10 Jul 2014 21:37:37 +0100
Message-ID: <30205.1405024657@warthog.procyon.org.uk>
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
To: Valdis.Kletnieks@vt.edu
Cc: dhowells@redhat.com, keyrings@linux-nfs.org, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> > Verify certificate chain in the X.509 certificates contained within the
> > PKCS#7 message as far as possible.  If any signature that we should be
> > able to verify fails, we reject the whole lot.
> 
> What happens if we see a signature that we shouldn't be able to verify?  Or
> should that changelog entry be reduced to "If any signature fails", period?

No.

When I say "any signature that we should be able to verify" I mean that a
signature for which we have an appropriate public key.

If we don't have a public key for a signature, we prune the trust chain at
that point.

What I mean is that the PKCS#7 message can have several signatures applied to
it.  We can form a chain from each signature going back through the X.509
certificates included in the PKCS#7 message:

	PKCS#7 ---> X.509 ---> X.509 ---> X.509 ---> X.509

where the PKCS#7 message and each X.509 cert has a signature that the next
X.509 cert in the chain can be used to verify with the public key contained
therein.

Any of the signatures in any of the chains can form an intersection point with
the keyring of public keys provided.  If there's a verified match on one or
more of them, we permit the message.

If any "Y ---> X.509" verification is rejected, we reject the whole message
because there's something wrong.  If an intersection point verification is
rejected, again we reject the whole message.

If there are no intersection points, we also reject the message, but with
ENOKEY rather than EKEYREJECTED.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
