Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE006.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ovy9I-0001J8-TP
	for kexec@lists.infradead.org; Wed, 15 Sep 2010 20:00:10 +0000
Subject: Re: Optimizations for purgatory
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <m1tylq7uh8.fsf@fess.ebiederm.org>
Date: Wed, 15 Sep 2010 15:00:02 -0500
Message-ID: <F154EA3B-DB1D-4981-AEC6-0687B64B0B99@freescale.com>
References: <A0628CD0-7A34-488D-A8C8-D8C12C6E8141@freescale.com>
	<m1tylq7uh8.fsf@fess.ebiederm.org>
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
Cc: kexec@lists.infradead.org


On Sep 15, 2010, at 1:05 PM, Eric W. Biederman wrote:

> Matthew McClintock <msm@freescale.com> writes:
>> 1) Is there any reason we don't just use -O0 instead of -0s? This
>> would provide a consistent set of compiler optimization flags across
>> all versions of gcc and we don't have to worry about a flag being
>> added or removed across versions. Or perhaps explicitly list all
>> desired flags?
> 
> So -O0 should do no optimization.

Right, a consistent set of optimizations (none) =)

> Last I looked the trick with the
> purgatory code was to compile it cleanly enough that we had support of
> the different relocation types needed in order to relocate the code
> at link time.  Usually this winds up being a small subset of the
> linking types of what the architecture supports.

AFAICT, it's not the linking types themselves. On ppc kexec-tools will die() if it encounters an unknown relocation type. I have also confirmed this with objdump -r. However, I must admit my naivety on the subject so I could be missing something here.

> 
>> 2) Has anyone else experienced issue with purgatory code not being
>> generated correctly? Specifically looking at a disassebly it looks
>> like -freorder-blocks is changed how functions return. On ppc for
>> example it appears that the functions are not returning using the link
>> register and instead are just branching.
> 
> The only problem I have previously seen is having an unsupported
> relocation type.  Can you confirm that isn't happening.  Ultimately
> if your gcc isn't compiling the code correctly unless we understand
> exactly why that doesn't work we can't make a sensible judgement
> on a good work around.

I confirmed 'objdump -r purgatory/purgatory.ro' does not have any entries covered by machine_apply_elf_rel(). I took some time to look at the assembly itself too and I notice one thing in common with the code that does not work. Basically, some functions don't use the link register to return... see below for a quick snippet:

Bad broken purgatory (with -Os):

00000000 <verify_sha256_digest>:
       0:       94 21 ff 50     stwu    r1,-176(r1)
       4:       7c 08 02 a6     mflr    r0
       8:       90 01 00 b4     stw     r0,180(r1)
       c:       bf a1 00 a4     stmw    r29,164(r1)
...[snip]...
     11c:       48 00 00 01     bl      11c <verify_sha256_digest+0x11c>
     120:       48 00 00 00     b       120 <verify_sha256_digest+0x120>
     124:       39 61 00 b0     addi    r11,r1,176
     128:       48 00 00 00     b       128 <verify_sha256_digest+0x128>  <-- Not using the link register return...

Good working purgatory (with -O0):

00000000 <verify_sha256_digest>:
       0:       94 21 ff 50     stwu    r1,-176(r1)
       4:       7c 08 02 a6     mflr    r0
       8:       90 01 00 b4     stw     r0,180(r1)
       c:       93 e1 00 ac     stw     r31,172(r1)
...[snip]...
     1c8:       7c 08 03 a6     mtlr    r0
     1cc:       83 eb ff fc     lwz     r31,-4(r11)
     1d0:       7d 61 5b 78     mr      r1,r11
     1d4:       4e 80 00 20     blr


-M




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
