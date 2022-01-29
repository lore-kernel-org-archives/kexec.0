From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 29 Jan 2022 17:19:42 +0100
Subject: [PATCH 1/3] memblock: define functions to set the usable memory
 range
In-Reply-To: <20220124210538.GA15943@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com>
 <Yd1cnquQFZoNE7FP@kernel.org>
 <20220124210538.GA15943@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Message-ID: <CAMj1kXHSGGUhmAdOFzpHJrMjfts-AgdpVJ6LJRkmm9_xLL0guw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, 24 Jan 2022 at 22:05, Frank van der Linden <fllinden@amazon.com> wrote:
>
> Meanwhile, it seems that this issue was already addressed in:
>
> https://lore.kernel.org/all/20211215021348.8766-1-kernelfans at gmail.com/
>
> ..which has now been pulled in, and sent to stable@ for 5.15. I
> somehow missed that message, and sent my change in a few weeks
> later.
>
> The fix to just reserve the ranges does seem a bit cleaner overall,
> but this will do fine.
>

Works for me.

