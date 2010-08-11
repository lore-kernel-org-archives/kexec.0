Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjJO2-0008P9-JP
	for kexec@lists.infradead.org; Wed, 11 Aug 2010 22:03:03 +0000
Message-ID: <4C631DF0.2040908@zytor.com>
Date: Wed, 11 Aug 2010 15:02:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Question regardin intel64 arch and page table setup
References: <20100811194734.GD23317@hmsreliant.think-freely.org>	<4C6301C2.5020808@zytor.com>
	<m1zkwsn7h0.fsf@fess.ebiederm.org>
In-Reply-To: <m1zkwsn7h0.fsf@fess.ebiederm.org>
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
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

On 08/11/2010 02:51 PM, Eric W. Biederman wrote:
> 
> 3) I would start just getting the normal kexec case to work.
>    The 64bit kernel does support starting at the 64bit entry point,
>    but I don't think it has been tested if loaded above 4G.
> 

I can guarantee that it hasn't; I looked at that code not all that long
ago and it's shock-full of 32- and 39-bit assumptions.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
