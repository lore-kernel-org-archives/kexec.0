Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZeQ5e-0007hF-52
 for kexec@lists.infradead.org; Tue, 22 Sep 2015 16:06:46 +0000
Date: Wed, 23 Sep 2015 00:07:04 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: Add prefix "kexec" to output message
Message-ID: <20150922160704.GA10225@dhcp-128-25.nay.redhat.com>
References: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com>
 <87fv2il0rq.fsf@x220.int.ebiederm.org>
 <20150914075056.GA13324@t440s.lenovo>
 <20150914084400.GA7953@localhost.localdomain>
 <20150915030804.GA7690@t440s.lenovo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150915030804.GA7690@t440s.lenovo>
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
To: Minfei Huang <mnfhuang@gmail.com>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On 09/15/15 at 11:08am, Minfei Huang wrote:
> On 09/14/15 at 04:44pm, Dave Young wrote:
> > On 09/14/15 at 03:50pm, Minfei Huang wrote:
> > > On 09/13/15 at 11:52am, Eric W. Biederman wrote:
> > > > Minfei Huang <mnfhuang@gmail.com> writes:
> > > > 
> > > > > kexec output message misses the prefix "kexec", when Dave Young split
> > > > > the kexec code. To keep the same format, add the prefix "kexec" to
> > > > > output message.
> > > > 
> > > > What of kexec_core? What of the messages that already have a prefix?
> > > > 
> > > 
> > > Hi, Eric.
> > > 
> > > Last commit(2965fa), Dave Young (dyoung@redhatcom) split the previous
> > > kernel/kexec.c into three pieces(kexec_core.c, kexec_file.c, kexec.c).
> > > The common functions used by both kexec and kexec_file are placed in
> > > file kernel/kexec_core.c.
> > > 
> > > The format of the output message likes "kexec: SYSC_kexec_load: hello,
> > > world" previously. Due to the missing prefix "kexec", now it like
> > > "SYSC_kexec_load: hello, world".
> > > 
> > > Dave Young misses the Macro pr_fmt to define the prefix output message
> > > in file kexec.c and kexec_file.c. I think the previous Macro was moved
> > > into the file kexec_core.c when Dave did the splitting.
> > 
> > I'm not sure it is proper to add prefix "kexec: " in all kexec*.c, so
> > only keep it in kexec_core.c.
> > 
> > There's already printks with prefix like "Kexec:", "crashkernel:" and
> > other strings. Adding another prefix before them looks odd. So either remove 
> > the prefix in kexec_core, or remove other prefixes already exists in kexec*.c
> > I would prefix to remove the "kexec:" prefix in kexec_core.c
> 
> Hi, Dave.
> 
> How about removing all of the prefix "crashkernel" in kexec_core. Thus
> we can be consistent with the output message prefix "kexec".

Ping, any comment is appreciate and helpful.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
