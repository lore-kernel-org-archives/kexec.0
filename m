From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Mar 2022 15:59:25 +0100
Subject: [PATCH v2] kexec-xen: Allow xen_kexec_exec() to return in case
 of Live Update
In-Reply-To: <20220323144418.1658-1-raphning@gmail.com>
References: <20220323144418.1658-1-raphning@gmail.com>
Message-ID: <Yjs1zcRAOWD5gwcP@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Mar 23, 2022 at 02:44:18PM +0000, Raphael Ning wrote:
> From: Raphael Ning <raphning@amazon.com>
> 
> Currently, my_exec() does not expect the Xen KEXEC_CMD_kexec hypercall
> to return on success, because it assumes that the hypercall always
> triggers an immediate reboot. However, for Live Update, the hypercall
> merely schedules the kexec operation and returns; the actual reboot
> happens asynchronously. [1]
> 
> Therefore, rework the Xen code path of my_exec() such that it does not
> treat a successfully processed Live Update request as an error. Also,
> rephrase the comment above the function to remove ambiguity.
> 
> [1] https://lists.xen.org/archives/html/xen-devel/2021-05/msg00286.html
> 
> Signed-off-by: Raphael Ning <raphning@amazon.com>

Thanks, applied.

