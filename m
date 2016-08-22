Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbg34-00027K-7u
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 03:37:19 +0000
Date: Mon, 22 Aug 2016 11:36:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Message-ID: <20160822033643.GA30937@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <105132489.pljZvDuEBr@hactar>
 <20160822031745.GA30489@dhcp-128-65.nay.redhat.com>
 <3959832.c4ESAKX1ch@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3959832.c4ESAKX1ch@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Eric Richter <erichte@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>

On 08/22/16 at 12:25am, Thiago Jung Bauermann wrote:
> Am Montag, 22 August 2016, 11:17:45 schrieb Dave Young:
> > On 08/18/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > > Hello Dave,
> > > 
> > > Thanks for your review!
> > > 
> > > [ Trimming down Cc: list a little to try to clear the "too many
> > > recipients"> 
> > >   mailing list restriction. ]
> > 
> > I also got "too many recipients".. Thanks for the trimming.
> 
> Didn't work though. What is the maximum number of recipients?

I have no idea as well..

> 
> > > Am Donnerstag, 18 August 2016, 17:03:30 schrieb Dave Young:
> > > > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > > > Adds checksum argument to kexec_add_buffer specifying whether the
> > > > > given
> > > > > segment should be part of the checksum calculation.
> > > > 
> > > > Since it is used with add buffer, could it be added to kbuf as a new
> > > > field?
> > > 
> > > I was on the fence about adding it as a new argument to kexec_add_buffer
> > > or as a new field to struct kexec_buf. Both alternatives make sense to
> > > me. I implemented your suggestion in the patch below, what do you
> > > think?> 
> > > > Like kbuf.no_checksum, default value is 0 that means checksum is
> > > > needed
> > > > if it is 1 then no need a checksum.
> > > 
> > > It's an interesting idea and I implemented it that way, though in
> > > practice all current users of struct kexec_buf put it on the stack so
> > > the field needs to be initialized explicitly.
> > 
> > No need to set it as false because it will be initialized to 0 by
> > default?
> 
> As far as I know, variables on the stack are not initialized. Only global 
> and static variables are.

But designated initializers will do it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
