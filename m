From: Raphael Ning <raphning@gmail.com>
Date: Wed, 23 Mar 2022 14:20:52 +0000
Subject: [PATCH] kexec-xen: Allow xen_kexec_exec() to return in case of
 Live Update
In-Reply-To: <Yjsp5zsc1lseY2M9@vergenet.net>
References: <20220314092115.48309-1-raphning@gmail.com>
 <Yjsp5zsc1lseY2M9@vergenet.net>
Message-ID: <b1aea785-1631-2afc-2d8c-c21067903978@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


On 23/03/2022 14:08, Simon Horman wrote:
> Hi Raphael,
> thanks for your patch. Overall I think this is good.
>
> Unfortunately I am seeing a build failure with this patch applied.
>
>  ../../kexec/kexec-xen.c:292:6: error: conflicting types for ?xen_kexec_exec?
>   292 | void xen_kexec_exec(uint64_t kexec_flags)
>       |      ^~~~~~~~~~~~~~
> In file included from ../../kexec/kexec-xen.c:6:
> ../../kexec/kexec.h:327:5: note: previous declaration of ?xen_kexec_exec? was here
>   327 | int xen_kexec_exec(uint64_t kexec_flags);
>       |     ^~~~~~~~~~~~~~
> make[1]: *** [Makefile:124: kexec/kexec-xen.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>
> See: https://github.com/horms/kexec-tools/runs/5661629877?check_suite_focus=true


Hi Simon,


Thanks for the review.? The conflicting declaration is for the --without-xen build, which I didn't test.? Let me fix that and post a new revision.


Raphael


