Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JIUfx-0004I7-BH
	for kexec@lists.infradead.org; Fri, 25 Jan 2008 19:57:28 +0000
Message-ID: <479A3E5B.1060107@zytor.com>
Date: Fri, 25 Jan 2008 11:54:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Kexec command line length
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080115152710.GA24435@redhat.com>
	<20080115170950.GA24359@hmsendeavour.rdu.redhat.com>
	<20080115173753.GB24435@redhat.com>
	<20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Neil Horman wrote:
> 
> And then we just point to it inside setup_linux_bootloader_parameters:
> ...
> if (real_mode->protocol_version >= 0x0202) {
>                 real_mode->cmd_line_ptr = real_mode_base + cmdline_offset;
>         }
> ....
> 
> So it seems, given that we already don't put it inside struct bootparam, we
> should be able to just expand it, yes?

Yup, you should.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
