Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7FD59D60
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5rJI5dJSpORspRIgPJSzFJ/vO7BoKUyaeN3OT2GWAw=; b=USt0cKeNuR8N8pNR70BmH6mpKZ
	zhwcCHj9AOaNj2jUiO5ys277nuoWC9j3b1NoAUN4i5ThGsXq4UuXG3+eJqpjMlnr2vFUcK5k9j67S
	TXkx7N6h9P9b37CGNTkm8OBSE+cZNzPglBgI4ZrNF9gIo+l/JtFbwgH3E4E4PEhAtnMzNA00eWQzQ
	yu7tYnLnkKH+qD3eDdnFSD27qecCa62L0g8E373n7aw1fRq5yIfUsfehETg6xh4KwyInIq0fTz6k7
	zEMqYJ+FpJzjkr9pibMhxC4d5sRuVjdLL+HIpsQRC/fjuJMpIFupmMV6JK0qDhTielSJMiqATBUT5
	per0yrnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFetP-00000008yYN-36Bz;
	Mon, 25 Nov 2024 19:37:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFetO-00000008yYD-2ZxD
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 19:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=U5rJI5dJSpORspRIgPJSzFJ/vO7BoKUyaeN3OT2GWAw=; b=jEuGuSX/9qBEhA0/IJathPaqDi
	Vx23+sjJ/fS7x27labYotnZhw7Iy4CfH85tGeM/lTzxhAFirO66I1qZoeULYzqJHULS07s8+HeUdn
	J4nqssyxE4G3WZdn2rr1nef79QF11YWIfWBiydYNtw31lGLIjOGe5NPWKRRqYcKmB6/cYlKTZ1jI9
	lQLA4qfvqITUBbJ+pmU39NiUExFCK6mzxUjlqU+K9Ml3pO2syiuxyMDecg4/875KB+ezazmp3RYXF
	wgN2ZBDCSQEaMYdqsfq6T7Hlsdf6THtY6hFioBI5eyfmNrWKLVRjkZ8Dd1wqo37FzyZ8XtUCGRH7Q
	y7QfI0ew==;
Received: from [172.31.31.140] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFetJ-000000017lv-0s4h;
	Mon, 25 Nov 2024 19:37:01 +0000
Date: Mon, 25 Nov 2024 19:36:03 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>, kexec@lists.infradead.org,
 =?ISO-8859-1?Q?Sch=F6nherr=2C_Jan_H=2E?= <jschoenh@amazon.de>,
 Rik van Riel <riel@surriel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: Re: [RFC PATCH] x86/mm: Disable PTI for kernel_ident_mapping_init()
User-Agent: K-9 Mail for Android
In-Reply-To: <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
References: <20241125100815.2512-1-dwmw2@infradead.org> <20241125100815.2512-2-dwmw2@infradead.org> <8b7cd35ab5fec39b80eda8d5907b641af14c3272.camel@infradead.org> <7f75150e9d5d358c8fdc38b591f99a252071fba0.camel@infradead.org> <7e7cb9b21f17b345d8539962093d0c030cca3e34.camel@infradead.org> <88a87314-45ad-47f7-a93a-a9a53d7e8745@intel.com> <5d385e4c06ebd218cfdc20ef4f208ee4abcfa252.camel@infradead.org> <5633d50d-0d61-4d18-b43f-11311b5ec920@intel.com>
Message-ID: <2C6F6BDC-16B5-41B4-AA3B-F2C23F4EBB75@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 25 November 2024 19:13:02 GMT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 11/25/24 10:53, David Woodhouse wrote:
>>> I think we have a lot of software-available space in the page table
>>> pointer entries=2E What would folks think if we set a special bit in t=
hose
>>> p4d entries that said:
>>>
>>> 	"I don't need to be propagated to
>>> 	the user portion of the page tables=2E"
>>>
>>> It would obviously get set in this code that you're trying to fix=2E I=
t
>>> might _also_ be able to be set in in "_USR", like here:
>>>
>>> #define _KERNPG_TABLE_NOENC=C2=A0 (__PP|__RW|=C2=A0=C2=A0 0|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
>>> #define _PAGE_TABLE_NOENC=C2=A0=C2=A0=C2=A0 (__PP|__RW|_USR|___A|=C2=
=A0=C2=A0 0|___D|=C2=A0=C2=A0 0|=C2=A0=C2=A0 0)
>>>
>>> like:
>>>
>>> #define _USR _PAGE_USER|_PAGE_SW_WHATEVER
>> In fact, do we even need a separate bit? Any PTE without the _PAGE_USER
>> bit set clearly doesn't need to be mirrored into the user page
>> tables=2E=2E=2E?
>
>I can't think of any exceptions where this would break off the top of my
>head=2E It seems too simple to work=2E ;)

I'll throw something together and see if it explodes=2E

