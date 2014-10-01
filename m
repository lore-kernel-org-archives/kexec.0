Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Oct 2014 10:56:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141001145602.GB13689@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412106877.6630.45.camel@smoke>
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
To: Geoff Levand <geoff@infradead.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Tue, Sep 30, 2014 at 12:54:37PM -0700, Geoff Levand wrote:

[..]
> > > +{
> > > +	switch (flag) {
> > > +	case IND_INDIRECTION:
> > > +	case IND_SOURCE:
> > > +		__flush_dcache_area(addr, PAGE_SIZE);
> > > +		break;
> > 
> > So what does __flush_dcache_area() do? Flush data caches. IIUC, addr
> > is virtual address at this point of time. While copying pages and
> > walking through the list, I am assuming you have switched off page
> > tables and you are in some kind of 1:1 physical mode. So how did
> > flushing data caches related to a virtual address help. I guess we
> > are not even accessing that virtual address now.
> 
> __flush_dcache_area(), and the underling aarch64 civac instruction
> operate on virtual addresses.  Here we are still running with the
> MMU on and the identity mapping has not yet been enabled.  This is
> the sequence:
> 
>   flush dcache -> turn off MMU, dcache -> access memory (PoC) directly 

Sorry, I don't understand that why do we need to flush dcache for source
and indirection page addresses. Some information here will help.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
