Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Fri, 18 Oct 2013 17:29:56 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
Message-ID: <20131018162956.GE25034@n2100.arm.linux.org.uk>
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1382112776-20300-1-git-send-email-zonque@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: kexec@lists.infradead.org, neumann@teufel.de, linux-arm-kernel@lists.infradead.org

On Fri, Oct 18, 2013 at 06:12:56PM +0200, Daniel Mack wrote:
> If the supplied atags/dtb pointer is located at memory inside the bss
> section, it will be erased by __mmap_switched. The problem is that the
> code that sets up the pointer can't know about a safe value unless it
> examines the kernel's symbol tables, so we should care about that case
> and relocate the area if necessary.
> 
> This patch does that from inside __vet_atags. In order to determine the
> size of the section in dtb cases, it reads the next word after the dtb
> binary magic, and also has to convert that value from big to CPU
> endianess. For the atags case, a total size of up to 4k is assumed for
> now.

I'm not convinced that this is a good solution.  If this oerlaps the
BSS region, it could well end up being overlapped by something else
more serious, like the data segment - at which point doing the fixup
here means we've already lost.

We already give the decompressor the size of the kernel's BSS and take
action if we believe that the kernel's BSS will overlap the DTB/ATAGs
there.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
