Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cxZEx-00089P-Ma
 for kexec@lists.infradead.org; Mon, 10 Apr 2017 13:20:21 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1491568577.4184.97.camel@linux.vnet.ibm.com>
References: <1491568577.4184.97.camel@linux.vnet.ibm.com>
 <1491551180.4184.50.camel@linux.vnet.ibm.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <21572.1491548994@warthog.procyon.org.uk>
 <27362.1491556638@warthog.procyon.org.uk>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
MIME-Version: 1.0
Content-ID: <13678.1491830392.1@warthog.procyon.org.uk>
Date: Mon, 10 Apr 2017 14:19:52 +0100
Message-ID: <13679.1491830392@warthog.procyon.org.uk>
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

> From an IMA perspective, either a file hash or signature are valid,
> but for this usage it must be a signature.

Not necessarily.  If IMA can guarantee that a module is the same based on its
hash rather than on a key, I would've thought that should be fine.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
