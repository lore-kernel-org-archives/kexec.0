Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210720150950.3669610-1-arnd@kernel.org>
 <20210720150950.3669610-2-arnd@kernel.org>
 <YPbtsU4GX6PL7/42@infradead.org>
In-Reply-To: <YPbtsU4GX6PL7/42@infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 21 Jul 2021 23:22:24 +0200
Message-ID: <CAK8P3a0OkF1G2kNTnn8Nh5aGAf5nnHNZqoQD3TB7mN2_VTV_9w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kexec: avoid compat_alloc_user_space
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Tue, Jul 20, 2021 at 5:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> This can be simplified a little more by killing off
> copy_user_segment_list entirely, using memdup_user and dropping the
> not really required _locked wrapper.  The locking move might make
> most sense as a separate prep patch.

Ok, I've integrated this as separate patches into my series now, will resend
after some more build testing.

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
