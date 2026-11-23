Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD4606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TVfpeEZD;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=terJ6FOM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ePtAq88JQv2mQTCltV6prJnPqbIrXTNiEgvUQLAl4To=; b=TVfpeEZDxRhr+p
	MOxyyEi7FUjyMyTd5E5Iy722b4z57LVhtbeg2f/v12/oNtVCacVtMZO+TCdvpSbILdXYmoL9ZhJQF
	NU2tn1Cg3G3NTt3/cWF7oSTPEFMgQKg9x55Xp5YQS1BE00TUeMQn/BQFZWTJTaa5VA/i1AhcTbOqK
	iM/fEiu4kd+I+Z0PhnC4leQTuaTeDpKj3Ly4vqQt9oQupGAbILsrfY8G9E3Kn8N0XJYPPM6gc7Tx4
	F6uuBTWkBGrxbBdbStuNAKi3RABhqrc9RJWYhmvFDPHa+k919NkiWeIzeTmeqFjaR64fG8DleHB6c
	a+SZYMjtpmYvHkeFHfbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYmE-00000004U70-2QfC;
	Mon, 23 Nov 2026 18:28:30 +0000
Received: from out-199.mta1.migadu.com ([2001:41d0:203:375::c7] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYm5-00000004U2l-0Qk7
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:28:25 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=ePtAq88JQv2mQTCltV6prJnPqbIrXTNiEgvUQLAl4To=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795458494; v=1; x=1796063294;
 b=terJ6FOMLbjLx3VoE3P2Fv0DRIKfB9L9FesGDQLqeEo0sybE3t2VY+wRe7CPJg1UqWyJv5Kf
 WD3nJ/U3eBH+UfZo+GtKUZTpKWdGlUvbyuS9sN13f4WLSVXyLxrgYIoL0EpNvQUWIvBlXbYBCcS
 sB24vX+NOTIlplCZrJBaeqX8C0zSh8+5Y/eAZs9ij6z+eS32B9kiVxH9DZFiBPtpI42587xk9ZN
 NkOqNzwGVel6MTPRbQL2i7eF4Pie+nIQloeQrVBR61hIe6+Zp6hYP1RIvRQ9XdQR98kEgNce6ek
 SG5pGYZI1sp3KuOQeHCh0H4ZSApHK9YE8DWd4uo0yp9Qw==
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 1b45b762173106e7;
	Mon, 23 Nov 2026 18:28:14 +0000
X-Mizu-Trace-ID: 1b45b762173106e7
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>, kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Nov 2026 10:27:57 -0800
Message-Id: <20261123-re-947c87d493b9@cressey.dev>
In-Reply-To: <20261112080050.GZ2668804@noisy.programming.kicks-ass.net>
References: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
 <20261112080050.GZ2668804@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_102822_432416_882568AA 
X-CRM114-Status: GOOD (  11.05  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12, Peter Zijlstra wrote:
> On Wed, Nov 11, 2026 at 03:26:59PM -0800, Ben Cressey wrote:
>> The check guards only the pointer, and not reliably under plain FineIBT,
>> which checks in the callee with IBT off. A failed check panics or hangs
>> with no CFI report, since load_segments() has reset GS.
>
> I don't understand this; what?

Sorry, that was hard to follow. The patch gives relocate_kernel() a kCFI
type. The call to it is then checked, and machine_kexec() no longer
needs __nocfi. It does not fix a known bug.

That paragraph was about the limits of the new check. Plain FineIBT
relies on IBT, which is off at the call, so it can miss a pointer to
code with no preamble. A failed check may panic or hang without a CFI
report because load_segments() has reset GS.

If you'd rather keep __nocfi, I'm happy to drop the patch. Otherwise
I'll send a v2 with simpler text.

