Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5oeG-0003sr-Rp
 for kexec@lists.infradead.org; Tue, 10 Apr 2018 08:29:11 +0000
Date: Tue, 10 Apr 2018 10:28:52 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Do not print ETA value if current
 progress is 0
Message-ID: <20180410102852.316f07df@ezekiel.suse.cz>
In-Reply-To: <20180410094707.0d1ec7f2@ezekiel.suse.cz>
References: <20180409114020.1b48ba8c@ezekiel.suse.cz>
 <90ec5728-2318-1074-0fc2-b02a69e6c7f4@redhat.com>
 <20180410094707.0d1ec7f2@ezekiel.suse.cz>
MIME-Version: 1.0
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
To: lijiang <lijiang@redhat.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

On Tue, 10 Apr 2018 09:47:07 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

>[...]
> Let's stay reasonable. Any value which represents more than a few
> (dozen) hours is not usable in practice. But hey, to make sure we
> cannot hit undefined behaviour, why not pass a double to
> eta_to_human_short()...

I gave it a second thought. Using math library functions just to print
a progress bar is overkill. In fact, using the FPU is already overkill.
Instead, I'm going to convert the calculations to pure integer
arithmetic.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
