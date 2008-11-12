Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0Lv1-0005Da-A8
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 20:02:27 +0000
Message-ID: <491B358D.2040304@kernel.org>
Date: Wed, 12 Nov 2008 11:59:09 -0800
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>
In-Reply-To: <1226519089-21647-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Bernhard Walle wrote:
> I had a problem that on i386 without PAE enabled the firmware memory map was
> wrong because a 64 bit address has been truncated:
> 
>         0000000000000000-000000000009f400 (System RAM)
>         000000000009f400-00000000000a0000 (reserved)
>         00000000fec10000-00000000fec11000 (reserved)
>         00000000fec20000-00000000fec21000 (reserved)
>         00000000fee00000-00000000fee10000 (reserved)
>         00000000ff800000-0000000100000000 (reserved)
>  --->   0000000000000000-00000000fffff000 (System RAM)  <---
>         00000000000f0000-0000000000100000 (reserved)
>         0000000000100000-00000000f57fa000 (System RAM)
>         00000000f57fa000-00000000f5800000 (ACPI Tables)
>         00000000fdc00000-00000000fdc01000 (reserved)
>         00000000fdc10000-00000000fdc11000 (reserved)
>         00000000fdc20000-00000000fdc21000 (reserved)
>         00000000fdc30000-00000000fdc31000 (reserved)
>         00000000fec00000-00000000fec01000 (reserved)
> 
> Just always using 64 bit is the most sane approach in my opinion.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

There are two options: either filter addresses outside the
resource_size_t range (since we don't manage that space and therefore
don't care about it) or, as you do, enforce 64-bitness.

I want to make sure, though, that we don't just end up pushing the
truncation further down in the code.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
