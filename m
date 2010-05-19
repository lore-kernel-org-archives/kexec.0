Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 19 May 2010 09:47:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] kexec-tools: ARM kernel crashdump support
Message-ID: <20100519004714.GK8536@verge.net.au>
References: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
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
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, May 05, 2010 at 09:58:31AM +0300, Mika Westerberg wrote:
> Hello,
> 
> These patches bring ARM kernel crashdump support for kexec-tools. Only zImage
> format is currently supported.
> 
> Changes to v1:
> 	- removed virtual address calculation based on phys_offset and moved
> 	  this to a separate function (phys_to_virt()) which can then be
> 	  redefined by archs if needed.
> 	- ARM version redefines this function and uses phys_offset for
> 	  calculating virtual addresses for kernel direct mapped region.
> 
> In addition, I have modified sample gdb macros from
> kernel/Documentation/kdump/gdbmacrox.txt to work with ARM crashdumps. They are
> included in the end of this email in case someone finds them useful.

Thanks, both patches applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
