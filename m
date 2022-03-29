From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Mar 2022 11:17:01 +0200
Subject: [ANNOUNCE] kexec-tools v2.0.24 preparation
In-Reply-To: <CALu+AoT+YxFyn27yhPKL5=90_=G-gm8OVA-bqhtpPEWMb-OCgQ@mail.gmail.com>
References: <Yjs2V0Ck/kvcJAKy@vergenet.net>
 <CALu+AoT+YxFyn27yhPKL5=90_=G-gm8OVA-bqhtpPEWMb-OCgQ@mail.gmail.com>
Message-ID: <YkLOjWtzcbhp2CZE@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sat, Mar 26, 2022 at 02:55:43PM +0800, RuiRui Yang wrote:
> Hi Simon,
> 
> Recently RH CKI detected a kexec/kdump failure with kexec_load being
> used,  the 2nd kernel can not boot, just reset to bios/firmware
> instead.
> 
> This only happens with gcc 12.x compiled kexec-tools,  add
> "-fno-tree-vectorize" to purgatory/Makefile CFLAGS make the bug
> dissappear, but I hope people can help to verify and confirm it does
> fix the problem.   It would be better to wait a few days so that we
> can fix it in the coming release, what do you think?
> 
> Cced Baoquan who is handling the issue..
> 
> Thanks!

Hi RuiRui,

thanks for letting us know.

I'm happy with delaying the release for a short time to accommodate
resolving this problem. Please let us know when there is some progress.

Kind regards,
Simon

