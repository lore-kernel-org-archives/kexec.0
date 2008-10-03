Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KlaCt-0004Ae-DP
	for kexec@lists.infradead.org; Fri, 03 Oct 2008 02:15:52 +0000
Message-ID: <48E57128.8030208@mxs.nes.nec.co.jp>
Date: Fri, 03 Oct 2008 10:11:04 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Problems writing ELF dumps with makedumpfile 1.2.9
References: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>	<28113A0489833849A1CF9EC16F4215434049544C88@GVW1097EXB.americas.hpqcorp.net>	<48D9EDDC.1070600@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F421543404958892C@GVW1097EXB.americas.hpqcorp.net>	<48DB29A6.3070608@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049588E80@GVW1097EXB.americas.hpqcorp.net>,
	<48DC6C23.1040704@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049EAF1D2@GVW1097EXB.americas.hpqcorp.net>	<28113A0489833849A1CF9EC16F4215434049D3EDB5@GVW1097EXB.americas.hpqcorp.net>	<48E05748.6020706@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049D3F31F@GVW1097EXB.americas.hpqcorp.net>	<48E191B1.7090809@mxs.nes.nec.co.jp>	<28113A0489833849A1CF9EC16F4215434049FC6BD3@GVW1097EXB.americas.hpqcorp.net>	<48E2DDEE.5050603@mxs.nes.nec.co.jp>	<48E30585.2090107@mxs.nes.nec.co.jp>
	<28113A0489833849A1CF9EC16F4215434376E9C963@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F4215434376E9C963@GVW1097EXB.americas.hpqcorp.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0157494233=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Worth, Kevin" <kevin.worth@hp.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============0157494233==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Kevin,

Worth, Kevin wrote:
> Using rc2 patch:
> 
> Copying data                       : [100 %]
> 
> The dumpfile is saved to /root/var/crash/vmcore.
> 
> makedumpfile Completed.
> 
> Aha! That worked!

Thank you for many tests, and I'm happy by your report :-)


> I'm suspecting the Ubuntu dev that changed the compile flags
> may not have realized what implications it could have.
>
> Additionally, we did resolve+test the problem with using -d
> values >1, so that is an improvement, as well. Thank you very
> much for your help in this, Ken'ichi! I'll be submitting 1.3.0
> to the Ubuntu devs as soon as the final version is released :)

I'm doing many regression tests, and I'll release the final
version until 10 October.


Thanks
Ken'ichi Ohmichi


--===============0157494233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0157494233==--
