Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Utirs-0004cu-Hl
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 18:30:29 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 1 Jul 2013 19:22:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F0670219005F
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 19:33:44 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r61ITpvC26083334
 for <kexec@lists.infradead.org>; Mon, 1 Jul 2013 18:29:51 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r61IU1oN025003
 for <kexec@lists.infradead.org>; Mon, 1 Jul 2013 12:30:01 -0600
Date: Mon, 1 Jul 2013 20:29:59 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/5] vmcore: Introduce ELF header in new memory feature
Message-ID: <20130701202959.178a1697@holzheu>
In-Reply-To: <20130701173727.GD9840@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130614185401.GL12023@redhat.com>
 <20130621161703.751b5f23@holzheu>
 <20130627193202.GK4899@redhat.com>
 <20130627202334.GL4899@redhat.com>
 <20130628101552.68aab404@holzheu>
 <20130701173727.GD9840@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, 1 Jul 2013 13:37:27 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jun 28, 2013 at 10:15:52AM +0200, Michael Holzheu wrote:
> > On Thu, 27 Jun 2013 16:23:34 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Thu, Jun 27, 2013 at 03:32:02PM -0400, Vivek Goyal wrote:
> > > > On Fri, Jun 21, 2013 at 04:17:03PM +0200, Michael Holzheu wrote:
> > > > > On Fri, 14 Jun 2013 14:54:02 -0400
> > > > > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > [snip]
> > 
> > > Thinking more about it, I think let us cleanup with this little ugly
> > > bit too so that future changes become easy.
> > > 
> > > Current convention is that elfcorehdr_addr and elfcorehdr_size are
> > > already set by arch code by the time vmcore.c starts reading it. Can't
> > > s390 allocate elf headers in early boot code and elfcorehdr_addr? Then
> > > we don't have to call elfcorehdr_alloc().
> > > 
> > > And once we are done with reading headers, we can call elfcorehdr_free()
> > > and s390 could free memory and set elfcorehdr_addr to ELFCORE_ADDR_ERR
> > > and elfcorehdr_size=0. That would signify that one can not try to read
> > > elf headers now and it must have been freed.
> > > 
> > > is_kdump_kernel() will continue to work as elfcorehdr_addr is
> > > ELFCORE_ADDR_ERR. And that will mean that either elfcorehdr were not
> > > readable/usable to begin with or they have been freed now.
> > 
> > Hello Vivek,
> > 
> > We would like to keep the alloc/free symmetry as you have suggested in a
> > previous mail. This also has the advantage that we do not have to rely
> > on the ordering of init calls.
> > 
> > Wouldn't it be sufficient to just set elfcorehdr_addr to ELFCORE_ADDR_ERR
> > after elfcorehdr_free() and remove the comment?
> > 
> 
> Hi Michael,
> 
> This has only one problem and that is what's the initialization semantics
> of elfcorehdr_addr. 
> 
> So far we expected it to be initialized very early in boot process and
> once this is set, any component in the system could figure out if it
> is kdump kernel (is_kdump_kernel()) and do kdump specific things.
> 
> But if we move initialization of this variable little late, then it
> might be a problem for early users of is_kdump_kernel(). Though right
> now I don't see drivers making use of it and only arch specific early
> boot up code seems to have it.
> 
> So either we can stick to existing semantics of initializing headers
> early or we could create a separate variable for is_kdump_kernel() which
> is set in early boot and then one can delay initialization of
> elfcorehdr_addr() in vmcore_init().

The later makes much sense to me. This would also make the s390 code
easier to read since we then could exchange some early kdump checks
with the official is_kdump() function.

Perhaps we can do that as an additional patch after we are ready with
this patch series.

> 
> Given the fact that I don't see any users of is_kdump_kernel() in arch
> independent directory, and I am assuming that you will tackle all early
> users of is_kdump_kernel() in s390, I will be fine even with your patch
> below.

Ok great, so I will send you the current patch set version 6 with all the
discussed changes.

Thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
