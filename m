Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLFG5-00085Z-L0
 for kexec@lists.infradead.org; Sun, 15 Sep 2013 16:33:17 +0000
Date: Sun, 15 Sep 2013 17:32:49 +0100
From: Hedi Berriche <hedi@sgi.com>
Subject: Re: [PATCH TRIVIAL] kexec: Typo s/the/then/
Message-ID: <20130915163249.GG8742@dangermouse.emea.sgi.com>
References: <1379237737-3070-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379237737-3070-1-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kexec@lists.infradead.org, Jiri Kosina <trivial@kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Sun, Sep 15, 2013 at 10:36 Geert Uytterhoeven wrote:
| Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
| ---
|  kernel/kexec.c |    2 +-
|  1 file changed, 1 insertion(+), 1 deletion(-)
| 
| diff --git a/kernel/kexec.c b/kernel/kexec.c
| index 2a74f30..490afc0 100644
| --- a/kernel/kexec.c
| +++ b/kernel/kexec.c
| @@ -921,7 +921,7 @@ static int kimage_load_segment(struct kimage *image,
|   *   reinitialize them.
|   *
|   * - A machine specific part that includes the syscall number
| - *   and the copies the image to it's final destination.  And
| + *   and then copies the image to it's final destination.  And
|   *   jumps into the image at entry.

Well, if you're fixing typos, might as well get rid of the wrong "it's"
and turn into "its".

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
