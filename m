Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.25])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NC8gN-0006hu-4R
	for kexec@lists.infradead.org; Sun, 22 Nov 2009 09:24:39 +0000
Message-ID: <4B09034E.40309@bwalle.de>
Date: Sun, 22 Nov 2009 10:24:30 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it	*libc
	agnostic. Tested against klibc and dietlibc.
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<20091122050350.GF2728@verge.net.au>
In-Reply-To: <20091122050350.GF2728@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Yuri Bushmelev <jay4mail@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org

Simon Horman schrieb:
>
>> +	char *line = malloc(sizeof_line); /* according to strdup() later */
>
> 	Could line be char line[1024] ?

Better would be a constant. However, 1024 is too less since the maximum
command line size can be 2048 currently on x86
(arch/x86/include/asm/setup.h, #define COMMAND_LINE_SIZE 2048).



Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
