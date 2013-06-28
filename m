Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UsTqx-0006Vf-BG
 for kexec@lists.infradead.org; Fri, 28 Jun 2013 08:16:24 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 09:13:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F6C51B08023
 for <kexec@lists.infradead.org>; Fri, 28 Jun 2013 09:15:56 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S8FifD54460448
 for <kexec@lists.infradead.org>; Fri, 28 Jun 2013 08:15:44 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5S8FtQN002970
 for <kexec@lists.infradead.org>; Fri, 28 Jun 2013 02:15:55 -0600
Date: Fri, 28 Jun 2013 10:15:52 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/5] vmcore: Introduce ELF header in new memory feature
Message-ID: <20130628101552.68aab404@holzheu>
In-Reply-To: <20130627202334.GL4899@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130614185401.GL12023@redhat.com>
 <20130621161703.751b5f23@holzheu>
 <20130627193202.GK4899@redhat.com>
 <20130627202334.GL4899@redhat.com>
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

On Thu, 27 Jun 2013 16:23:34 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Thu, Jun 27, 2013 at 03:32:02PM -0400, Vivek Goyal wrote:
> > On Fri, Jun 21, 2013 at 04:17:03PM +0200, Michael Holzheu wrote:
> > > On Fri, 14 Jun 2013 14:54:02 -0400
> > > Vivek Goyal <vgoyal@redhat.com> wrote:

[snip]

> Thinking more about it, I think let us cleanup with this little ugly
> bit too so that future changes become easy.
> 
> Current convention is that elfcorehdr_addr and elfcorehdr_size are
> already set by arch code by the time vmcore.c starts reading it. Can't
> s390 allocate elf headers in early boot code and elfcorehdr_addr? Then
> we don't have to call elfcorehdr_alloc().
> 
> And once we are done with reading headers, we can call elfcorehdr_free()
> and s390 could free memory and set elfcorehdr_addr to ELFCORE_ADDR_ERR
> and elfcorehdr_size=0. That would signify that one can not try to read
> elf headers now and it must have been freed.
> 
> is_kdump_kernel() will continue to work as elfcorehdr_addr is
> ELFCORE_ADDR_ERR. And that will mean that either elfcorehdr were not
> readable/usable to begin with or they have been freed now.

Hello Vivek,

We would like to keep the alloc/free symmetry as you have suggested in a
previous mail. This also has the advantage that we do not have to rely
on the ordering of init calls.

Wouldn't it be sufficient to just set elfcorehdr_addr to ELFCORE_ADDR_ERR
after elfcorehdr_free() and remove the comment?

So the code would look like the following:

static int __init vmcore_init(void)
{
        int rc = 0;

        /* Allow architectures to allocate ELF header in 2nd kernel */
        rc = elfcorehdr_alloc(&elfcorehdr_addr, &elfcorehdr_size);
        if (rc)
                return rc;
        /*
         * If elfcorehdr= has been passed in cmdline or created in 2nd kernel,
         * then capture the dump.
         */
        if (!(is_vmcore_usable()))
                return rc;
        rc = parse_crash_elf_headers();
        if (rc) {
                pr_warn("Kdump: vmcore not initialized\n");
                return rc;
        }
        elfcorehdr_free(elfcorehdr_addr);
	elfcorehdr_addr = ELFCORE_ADDR_ERR;

        proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &proc_vmcore_operations);
        if (proc_vmcore)
                proc_vmcore->size = vmcore_size;
        return 0;
}

This looks clean for me.

What do you think?

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
