Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uxduu-0001Jm-Sx
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 14:01:49 +0000
Message-ID: <51E00C32.6090204@citrix.com>
Date: Fri, 12 Jul 2013 15:01:22 +0100
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/7] Xen fixes and minor cleanups
References: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
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
Cc: kexec@lists.infradead.org, xen-devel@lists.xensource.com, kumagai-atsushi@mxc.nes.nec.co.jp

On 12/07/13 14:48, Daniel Kiper wrote:
> Hi,
>
> This patch series contains following Xen fixes and cleanups:
>   - xen: Improve calculation of beginning of virtual address space,
>   - elf: Increase buf size in get_pt_note_info(),
>   - xen: Take into account new frame table address since Xen 4.3,
>   - xen: Enforce page size only when xen-syms file is used,
>   - Mute some compiler warnings,
>   - Use elf_getshdrstrndx() instead of elf_getshstrndx(),
>   - Do not break progress messages.
>
> All patches were tested with Xen versions up to 4.3.
>
> Daniel

I presume these are all kexec-tools fixes, given the files patched, but
no specific statement one way or another?

~Andrew

>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
