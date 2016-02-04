Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRRyE-00049i-3F
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 22:01:46 +0000
Date: Thu, 4 Feb 2016 23:01:22 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v3.1] firmware: clean up filesystem load exit path
Message-ID: <20160204220122.GL12481@wotan.suse.de>
References: <20160204211501.GA14755@www.outflux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160204211501.GA14755@www.outflux.net>
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
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Josh Boyer <jwboyer@fedoraproject.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, Feb 04, 2016 at 01:15:02PM -0800, Kees Cook wrote:
> This makes the error and success paths more readable while trying to
> load firmware from the filesystem.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Josh Boyer <jwboyer@fedoraproject.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Thanks,

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

> ---
> Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"

Mimi, feel free to pick up as a replacement in your series.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
