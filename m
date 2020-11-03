Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 3 Nov 2020 08:37:03 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
Message-ID: <20201103083703.GD9092@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102123151.2860165-5-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

On Mon, Nov 02, 2020 at 01:31:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These are all handled correctly when calling the native
> system call entry point, so remove the special cases.

Ok, this is where you do it.  I think this belongs into the main
patches.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
