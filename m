Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn8xm-00037i-Bl
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 13:52:51 +0000
Message-Id: <4FF70A09020000780008E155@nat28.tlf.novell.com>
Date: Fri, 06 Jul 2012 14:53:45 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S
 during kexec boot
References: <20120705210607.GA26908@aepfle.de>
 <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
In-Reply-To: <20120706133105.GA20600@aepfle.de>
Mime-Version: 1.0
Content-Disposition: inline
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
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

>>> On 06.07.12 at 15:31, Olaf Hering <olaf@aepfle.de> wrote:
> On Fri, Jul 06, Jan Beulich wrote:
> 
>> >>> On 06.07.12 at 14:07, Olaf Hering <olaf@aepfle.de> wrote:
>> > But adding some debug to inspect
>> > *output in parse_elf() shows that the second entry in program headers is
>> > already shifted by 44 bytes in my testing, the others are shifted by the
>> > same amount.
>> 
>> Unfortunately it's not clear what is shifted - the printout below
>> looks just fine. Also, from your first mail I understood that the shift
>> there was by an amount not divisible by 4 - does that amount vary?
> 
> The memory location of the second LOAD entry (the .data section) is wrong.
> It should be at 0x1c00000, but in fact its content starts at 0x1c0002c.
> I looked at the x86 boot code, the vmlinux is gzipped and placed as
> binary blob, which is then extracted by decompress().

Are the virtual addresses then offset as well?

Is phdr->p_offset sane?

And you didn't clarify whether the offset was always the same.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
