Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URobr-0003Cw-LK
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 18:58:36 +0000
Message-ID: <516C4DD6.4020805@citrix.com>
Date: Mon, 15 Apr 2013 19:58:30 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-6-git-send-email-david.vrabel@citrix.com>
 <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 09/04/13 22:02, Daniel Kiper wrote:
> On Mon, Apr 08, 2013 at 07:59:50PM +0100, David Vrabel wrote:
>>
>> +
>> +        /* Jump to identity mapped code. */
>> +        movq %rdi, %r9
>> +        addq $(identity_mapped - kexec_reloc), %r9
>> +
>> +        jmp *%r9
> 
> jmpq *(identity_mapped - kexec_reloc)(%rdi)

This isn't equivalent.  It loads the value at the specified memory
location and jumps to that address.

        leaq (identity_mapped - kexec_reloc)(%rdi), %rax
        jmpq *%rax

Does the right thing.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
