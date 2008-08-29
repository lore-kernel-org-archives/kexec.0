Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.173])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYudJ-00076V-8y
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 03:26:45 +0000
Received: by wf-out-1314.google.com with SMTP id 28so776354wfc.24
	for <kexec@lists.infradead.org>; Thu, 28 Aug 2008 20:26:43 -0700 (PDT)
Message-ID: <431757fd0808282026x257b7080k48e20c8e12343119@mail.gmail.com>
Date: Thu, 28 Aug 2008 20:26:43 -0700
From: "Manish Lachwani" <mlachwani@gmail.com>
Subject: KEXEC on ARM V6
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello!

I am trying to get kexec working on an ARM V6 board (1136) using the
2.0.0 version of the kexec-tools.

Firstly, it appears that uname checks for "arm". The ARM V6 board that
I have has "armv6l" in the uname. I have hacked this support for
armv6l.

const struct arch_map_entry arches[] = {
       { "arm", KEXEC_ARCH_ARM },
       { "armv6l", KEXEC_ARCH_ARM },
       { 0 },
};

I can send a patch as well.

The loading seems to work ok. On "kexec -e", I see:

Starting new kernel
Uncompressing Linux...................................................................................................

crc error

 -- System halted


Has kexec been tried on any ARM yet? unfortunately, I dont have
another board to try on. Response is highly appreciated.

thanks,
Manish

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
