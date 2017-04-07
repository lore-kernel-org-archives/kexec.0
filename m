Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwQ1X-0008Sv-Tc
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 09:17:45 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1491551180.4184.50.camel@linux.vnet.ibm.com>
References: <1491551180.4184.50.camel@linux.vnet.ibm.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <21572.1491548994@warthog.procyon.org.uk>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
MIME-Version: 1.0
Content-ID: <27361.1491556638.1@warthog.procyon.org.uk>
Date: Fri, 07 Apr 2017 10:17:18 +0100
Message-ID: <27362.1491556638@warthog.procyon.org.uk>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Chun-Yi Lee <jlee@suse.com>, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com, Dave Young <dyoung@redhat.com>

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > Okay, fair enough.  I can stick in an OR with an IS_ENABLED on some IMA
> > symbol.  CONFIG_IMA_KEXEC maybe?  And also require IMA be enabled?
> 
> Not quite, since as Dave pointed out, IMA is policy driven.  As a
> policy is installed, we could set a flag.

Does such a flag exist as yet?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
