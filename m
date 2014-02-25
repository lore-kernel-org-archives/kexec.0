Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WILIl-0008Q3-Js
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 16:56:16 +0000
Message-ID: <530CCB0E.3060009@zytor.com>
Date: Tue, 25 Feb 2014 08:55:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] kexec: Create a relocatable object called purgatory
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
 <530B989B.8010507@zytor.com> <20140225164342.GC2701@redhat.com>
In-Reply-To: <20140225164342.GC2701@redhat.com>
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
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, greg@kroah.com

On 02/25/2014 08:43 AM, Vivek Goyal wrote:
> 
> W.r.t sharing the code with arch/x86/boot/, I am not sure how to do it.
> 

Pretty much we have been doing #includes (a bit sad, I know)... there
are already a lot of them between arch/x86/boot,
arch/x86/boot/compressed, and arch/x86/realmode.  In that sense
collecting these "limited environments" together and have these kinds of
stuff together in one place seems like a good idea.

Does purgatory move large amounts of data around?  If so, we probably
*do* want to use rep movsl, but otherwise you're definitely right, using
C code makes more sense.

> I see two implementations of memcpy() under arch/x86/boot.
> 
> One is in copy.S. This is assembly code and looks like is supposed to
> run in 16bit mode. (code16).
> 
> Other one is in compressed/misc.c and there are two definitions, one
> for 32bit and one fore 64bit.

They are basically the 16-, 32-, and 64-bit variants of the same code.

> I am not sure why there is a need to write memcpy() in assembly when
> C will do just fine for my case. I don't have to write two versions of
> memcpy() and use it both for 32bit and 64bit.

The point would be to use the ones we already have.

> So I can just make all the purgatory code share same version of memcpy(),
> memcmp() and memset(), is that fine. I have taken implementations of
> these functions from lib/string.c

It depends on if you care about performance.  For memcpy() and memset()
in particular, the CPU has internally optimized versions of these that
beats C at least on any newer silicon.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
