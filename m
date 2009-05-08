Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2V6s-0004CF-Jy
	for kexec@lists.infradead.org; Fri, 08 May 2009 18:48:00 +0000
Message-ID: <4A047E53.8040003@intel.com>
Date: Fri, 08 May 2009 11:47:47 -0700
From: "H. Peter Anvin" <h.peter.anvin@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/14] RFC: x86: relocatable kernel changes
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>	<m14ovwz8ua.fsf@fess.ebiederm.org>
	<4A03C3BB.3070401@intel.com> <m1tz3wgk3n.fsf@fess.ebiederm.org>
In-Reply-To: <m1tz3wgk3n.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hbabu@us.ibm.com" <hbabu@us.ibm.com>, "Huang,
	Ying" <ying.huang@intel.com>, "mingo@elte.hu" <mingo@elte.hu>, "H. Peter Anvin" <hpa@linux.intel.com>, "sam@ravnborg.org" <sam@ravnborg.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Eric W. Biederman wrote:
> 
> Perhaps we should have:
> init_size
> best start (As a 64bit field please)
> optimum align  (Or we flip it around)
> 

Thinking about this some more, I think you have a very good idea here.

Specifically, if we retcon the existing kernel_alignment field as 
"preferred alignment" (ignoring the naming issue for a bit), we can set 
that to 16 MB, which should give us correct behavior for all previously 
existing bootloaders.  Then we create a new "minimum alignment" field 
that newer bootloaders can use to relax the alignment requirement -- all 
the way down to 4K in the case of i386.  We document this field 
indicating that the bootloader should find the highest power of 2 <= 
preferred alignment, but down to this number.

The preferred address field becomes a readonly, advisory field; with it 
being readonly there aren't any funny issues with a strange loader 
writing a 64-bit address for a kernel which can't handle it (64-bit 
loading will still need substantial protocol changes, including how to 
find the entry point.)

Does that work for you?  That *should* address all your concerns, right?

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
