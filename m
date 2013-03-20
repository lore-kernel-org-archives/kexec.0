Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI7Qh-0003ty-OV
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 01:03:00 +0000
Message-ID: <51490ABD.3050205@zytor.com>
Date: Tue, 19 Mar 2013 18:02:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
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
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-pci@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 03/18/2013 02:32 PM, Matthew Garrett wrote:
> 
> This means we can return our focus to the kernel. There's currently a number
> of kernel interfaces that permit privileged userspace to modify the running
> kernel. These are currently protected by CAP_SYS_RAWIO, but unfortunately
> the semantics of this capability are poorly defined and it now covers a large
> superset of the desired behaviour.
> 

... except it doesn't.

Looking at it in detail, EVERYTHING in CAP_SYS_RAWIO has the possibility
of compromising the kernel, because they let device drivers be bypassed,
which means arbitrary DMA, which means you have everything.

Now, a lot of the abuses of CAP_SYS_RAWIO have clearly been added by
people who had *no bloody clue* what that capability meant, but it
really doesn't change the fact that pretty much if you have
CAP_SYS_RAWIO you have the machine.

So just reject CAP_SYS_RAWIO.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
