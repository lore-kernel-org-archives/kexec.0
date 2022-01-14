From: Frank van der Linden <fllinden@amazon.com>
Date: Fri, 14 Jan 2022 00:22:52 +0000
Subject: [PATCH 1/3] memblock: define functions to set the usable memory
 range
In-Reply-To: <20220114001046.GA10609@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
 <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <YeBiV8fuCCLWyHYb@kernel.org>
 <20220114001046.GA10609@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Message-ID: <20220114002252.GA22602@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Jan 14, 2022 at 12:10:46AM +0000, Frank van der Linden wrote:
> Thanks for discussing this further! I tried the above change, although
> I wrapped it in an if (cap_mem_size != 0), so that a normal kernel
> doesn't get its entire memory marked as reserved.

Just to clarify: I had to do that because the code is slightly different
on 5.15, where I tried it. It wasn't a bug in the proposed patch.

Anyway, will try 5.17-rc tomorrow, I'll let you know, thanks again.

- Frank

