Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [80.67.31.28] (helo=smtprelay01.ispgateway.de)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NS4oj-00023v-Q0
	for kexec@lists.infradead.org; Tue, 05 Jan 2010 08:31:10 +0000
Message-ID: <4B42F8AF.3020304@bwalle.de>
Date: Tue, 05 Jan 2010 09:30:39 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: Linux kernel crash dumps for ARM
References: <EB1A7C66AD0C92419BFFC785A947865A09EA8C9129@BLRINMSMBX01.bglrodc.lntinfotech.com>
	<m17hrx9lgo.fsf@fess.ebiederm.org>
In-Reply-To: <m17hrx9lgo.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "rmk+lkml@arm.linux.org.uk" <rmk+lkml@arm.linux.org.uk>, Venkappa Mala <Venkappa.Mala@lntinfotech.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Am 05.01.2010 06:20, schrieb Eric W. Biederman:
>>
>> 3) In lkcd, netdump,diskdump, mini kernel dump and kdump/kexec tools,
>>
>>    - which is the best choice for ARM or are there any best crash
dump tool for ARM?

LKCD is more or less dead (in favour of kdump) on any plattform. It
doesn't work with recent kernels.


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
