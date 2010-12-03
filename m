Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1POZAv-0001GJ-H9
	for kexec@lists.infradead.org; Fri, 03 Dec 2010 17:12:02 +0000
Date: Fri, 3 Dec 2010 18:11:48 +0100
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: kdump broken on 2.6.37-rc4
Message-ID: <20101203171147.GA2299@redhat.com>
References: <20101203111623.GA2741@redhat.com>
	<AANLkTi=Xvbi5M_cNRL=wC+uwksG08SiCyWcqdmwB_5TU@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=Xvbi5M_cNRL=wC+uwksG08SiCyWcqdmwB_5TU@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Dec 03, 2010 at 06:46:09PM +0300, Maxim Uvarov wrote:
> 2010/12/3 Stanislaw Gruszka <sgruszka@redhat.com>:
> > On my T-60 laptop, i686 system with 2.6.37-rc4 kernel,
> > "echo c > /proc/sysrq-trigger" just hung the system. Kdump
> > works on 2.6.36. Is this known issue? If not, what info
> > I should provide to solve it (I think the easiest way
> > to solve the problem would be bisect) ?
> >
> > Stanislaw
> >
> 
> I tested x86 QEMU yesterday with the latest git. It worked.
> Might be something target specific.., What does console print?

Here is the photo 
http://people.redhat.com/sgruszka/20101203_005.jpg

There are two BUGs, first "sleeping function called from invalid
context" and then "unable to handle null pointer dereference".

Stanislaw

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
