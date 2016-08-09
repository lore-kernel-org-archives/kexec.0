Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out4.electric.net ([192.162.216.184])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX7E1-0004OG-Iv
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 13:37:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/7] ima: on soft reboot, restore the measurement list
Date: Tue, 9 Aug 2016 13:35:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
In-Reply-To: <3544655.o5QPxko4Ba@hactar>
Content-Language: en-US
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
To: 'Thiago Jung Bauermann' <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-ima-devel@lists.sourceforge.net" <linux-ima-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

From: Thiago Jung Bauermann
> Sent: 09 August 2016 14:19
...
> > > > +/* Some details preceding the binary serialized measurement list */
> > > > +struct ima_kexec_hdr {
> > > > +	unsigned short version;
> > > > +	unsigned long buffer_size;
> > > > +	unsigned long count;
> > > > +} __packed;
> > > > +
> > >
> > > Am I understanding it correctly that this structure is passed between
> > > kernels?
> > Yes, the header prefixes the measurement list, which is being passed on
> > the same computer to the next kernel.  Could the architecture (eg.
> > LE/BE) change between soft re-boots?
> 
> Yes. I am able to boot a BE kernel from an LE kernel with my patches.

64bit kernel to/from 32bit one? (if that makes sense on the hardware).

> Whether we want to support that or not is another question...

In which case shouldn't they be annotated with the endianness??

Also why '__packed' - guarantees sub-optimal code generation.
Much better to include explicit padding to align everything.

	David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
