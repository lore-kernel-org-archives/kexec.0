From: bhe <bhe@redhat.com>
Date: Tue, 29 Mar 2022 18:16:43 +0800
Subject: [ANNOUNCE] kexec-tools v2.0.24 preparation
In-Reply-To: <YkLOjWtzcbhp2CZE@vergenet.net>
References: <Yjs2V0Ck/kvcJAKy@vergenet.net>
 <CALu+AoT+YxFyn27yhPKL5=90_=G-gm8OVA-bqhtpPEWMb-OCgQ@mail.gmail.com>
 <YkLOjWtzcbhp2CZE@vergenet.net>
Message-ID: <YkLci3fU3PYmRNig@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/29/22 at 11:17am, Simon Horman wrote:
> On Sat, Mar 26, 2022 at 02:55:43PM +0800, RuiRui Yang wrote:
> > Hi Simon,
> > 
> > Recently RH CKI detected a kexec/kdump failure with kexec_load being
> > used,  the 2nd kernel can not boot, just reset to bios/firmware
> > instead.
> > 
> > This only happens with gcc 12.x compiled kexec-tools,  add
> > "-fno-tree-vectorize" to purgatory/Makefile CFLAGS make the bug
> > dissappear, but I hope people can help to verify and confirm it does
> > fix the problem.   It would be better to wait a few days so that we
> > can fix it in the coming release, what do you think?
> > 
> > Cced Baoquan who is handling the issue..
> > 
> > Thanks!
> 
> Hi RuiRui,
> 
> thanks for letting us know.
> 
> I'm happy with delaying the release for a short time to accommodate
> resolving this problem. Please let us know when there is some progress.

Thanks for quick response, Simon. I have sent a patch to fix this,
please check the patch v2 with subject 'purgatory: do not enable
vectorization automatically for purgatory compiling'.

I tested on machine where the issue can stably reproduced, and can
confirm adding -fno-tree-vectorize to compiling options of purgatory can
fix the issue.

Dave, please check if it is expected from you.


