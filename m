Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tundra.namei.org ([65.99.196.166])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIUlT-0003dJ-DX
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 01:58:00 +0000
Date: Thu, 21 Mar 2013 12:58:04 +1100 (EST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
In-Reply-To: <1363797717.2580.10.camel@falcor1.watson.ibm.com>
Message-ID: <alpine.LRH.2.02.1303211257420.9518@tundra.namei.org>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
 <1363797717.2580.10.camel@falcor1.watson.ibm.com>
MIME-Version: 1.0
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org

On Wed, 20 Mar 2013, Mimi Zohar wrote:

> On Tue, 2013-03-19 at 15:47 +1100, James Morris wrote:
> > On Mon, 18 Mar 2013, Matthew Garrett wrote:
> > 
> > > This patch introduces CAP_COMPROMISE_KERNEL. 
> > 
> > I'd like to see this named CAP_MODIFY_KERNEL, which is more accurate and 
> > less emotive.  Otherwise I think core kernel developers will be scratching 
> > their head over where to sprinkle this.
> > 
> > Apart from that, I like the idea, especially when it's wired up to MAC 
> > security.
> 
> Matthrew, perhaps you could clarify whether this will be tied to MAC
> security.

All capabilities are, via LSM.


-- 
James Morris
<jmorris@namei.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
