From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Mar 2022 15:08:39 +0100
Subject: [PATCH] kexec-xen: Allow xen_kexec_exec() to return in case of
 Live Update
In-Reply-To: <20220314092115.48309-1-raphning@gmail.com>
References: <20220314092115.48309-1-raphning@gmail.com>
Message-ID: <Yjsp5zsc1lseY2M9@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Mar 14, 2022 at 09:21:15AM +0000, Raphael Ning wrote:
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

Hi Raphael,

thanks for your patch. Overall I think this is good.

Unfortunately I am seeing a build failure with this patch applied.

 ../../kexec/kexec-xen.c:292:6: error: conflicting types for ?xen_kexec_exec?
  292 | void xen_kexec_exec(uint64_t kexec_flags)
      |      ^~~~~~~~~~~~~~
In file included from ../../kexec/kexec-xen.c:6:
../../kexec/kexec.h:327:5: note: previous declaration of ?xen_kexec_exec? was here
  327 | int xen_kexec_exec(uint64_t kexec_flags);
      |     ^~~~~~~~~~~~~~
make[1]: *** [Makefile:124: kexec/kexec-xen.o] Error 1
make[1]: *** Waiting for unfinished jobs....

See: https://github.com/horms/kexec-tools/runs/5661629877?check_suite_focus=true

