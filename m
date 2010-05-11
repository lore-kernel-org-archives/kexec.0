Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 11 May 2010 12:28:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH - kexec] arm: place initrd to safer place according to
	zImage length
Message-ID: <20100511032850.GH7649@verge.net.au>
References: <h2xf17812d71004221936s779a4585r8b458f7f2630f7b1@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <h2xf17812d71004221936s779a4585r8b458f7f2630f7b1@mail.gmail.com>
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
To: Eric Miao <eric.miao@canonical.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 23, 2010 at 10:36:44AM +0800, Eric Miao wrote:
> commit 4b6d55c7780dbf383c6b64e560d459d15a891006
> Author: Eric Miao <eric.miao@canonical.com>
> Date:   Fri Apr 23 10:19:43 2010 +0800
> 
>     arm: place initrd to safer place according to zImage length
> 
>     The original fixed address of 0x800000 may be overwritten after the
>     kernel is decompressed.  Assume a maximum decompression ratio of 4
>     and place initrd right after that, just to be safer.
> 
>     Signed-off-by: Eric Miao <eric.miao@canonical.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
