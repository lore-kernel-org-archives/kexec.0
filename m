Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDwS-008PBI-J5
 for kexec@lists.infradead.org; Thu, 11 Mar 2021 05:33:02 +0000
Date: Wed, 10 Mar 2021 21:32:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: Add kexec reboot string
Message-Id: <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
In-Reply-To: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Guohan Lu <lguohan@gmail.com>, Joe LeVeque <jolevequ@microsoft.com>

On Thu,  4 Mar 2021 13:46:26 +0100 Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> From: Joe LeVeque <jolevequ@microsoft.com>
> 
> The purpose is to notify the kernel module for fast reboot.
> 
> Upstream a patch from the SONiC network operating system [1].
> 
> [1]: https://github.com/Azure/sonic-linux-kernel/pull/46
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

We should have Joe's signed-off-by: for this.  Joe, can you please send
it?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
