Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hxz0B-00045f-7k
	for kexec@lists.infradead.org; Tue, 12 Jun 2007 01:33:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [KJ PATCH] Replacing memcpy(dest, src,
	PAGE_SIZE) with copy_page(dest,
	src) in arch/i386/kernel/machine_kexec.c
References: <1181616342.2282.8.camel@shani-win>
Date: Mon, 11 Jun 2007 23:32:03 -0600
In-Reply-To: <1181616342.2282.8.camel@shani-win> (Shani Moideen's message of
	"Tue, 12 Jun 2007 08:15:41 +0530")
Message-ID: <m1vedtpwks.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Shani Moideen <shani.moideen@wipro.com>
Cc: kernel-janitors@lists.osdl.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Shani Moideen <shani.moideen@wipro.com> writes:

> Hi,
> Replacing memcpy(dest,src,PAGE_SIZE) with copy_page(dest,src) in
> arch/i386/kernel/machine_kexec.c.

Please no.

People get creative in copy_page (especially mmx_copy_page),
and this code path need something simple and stupid, that
will work every time, especially when things are messed up
elsewhere.

Ideally we would actually do all of the setup before this point.
but that is another issue entirely.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
