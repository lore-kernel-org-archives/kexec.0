Return-path: <kexec-bounces@lists.infradead.org>
Received: from mail.ihtfp.org ([204.107.200.6])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IbPHr-0001kt-9N
	for kexec@lists.infradead.org; Sat, 29 Sep 2007 00:30:26 +0100
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>
	<46FD03CD.9060404@windriver.com> <sjmve9uj3d2.fsf@pgpdev.ihtfp.org>
	<46FD1B6A.3000500@windriver.com>
	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>
	<46FD2CFB.9010404@windriver.com> <46FD75E1.3090602@bluelane.com>
	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: Fri, 28 Sep 2007 19:29:46 -0400
In-Reply-To: <m18x6qbfip.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Fri\, 28 Sep 2007 16\:18\:22 -0600")
Message-ID: <sjm641uid1x.fsf@pgpdev.ihtfp.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kgdb-bugreport@lists.sourceforge.net, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, pete@bluelane.com

ebiederm@xmission.com (Eric W. Biederman) writes:

> Pete/Piet Delaney <pete@bluelane.com> writes:
>
>> Jason Wessel wrote:
>>
>> Shouldn't crash, kdump and kgdb take into consideration a
>> shift in the kernel so that gdb works normally?
>>
>> Seems that having the kgdb stub knowledgeable of a shift
>> in the kernel might be easy to compensate for. Perhaps
>> just mapping all reads and writes that lie within the
>> original kernel segments to the shifted addresses.
>
> Good question.
>
> I remember hearing some oddball reports about something like this.
> My memory says what little tracking that happened pointed in
> the direction of a confused gdb.

Well, gdb agrees with System.map, so I'm sure that gdb itself is
okay.  It's certainly possible that that the kgdb stub is weird,
but /proc/kallsyms doesn't match System.map, and THAT'S what's
confusing me most of all.

> In particular unless you deliberately run a kernel at a different
> address linux kernels should run at the addresses they were built
> for so there should be nothing that has to be done.

In my case I'm not doing anything special; the bzImage is definitely
built from the vmlinux, but the symbols are definitely offset.
Granted, I'm using the Fedora RPM build, so it's possible that THAT is
doing something weird.  Unlikely, but possible.  Using the
add-symbol-file seems to have mostly worked for me, and adding the
symbol file of my module seems to work, too.

Hopefully this will all get merged into the mainline sometime
soon and the gdb patches will get fed up into the gdb mainline
and everyone can be happy..  :)

> I'm running on foggy memories so something may have changed
> since last time I looked.

Which was how long ago?  ;)

-derek

> Eric
>
>
>>
>> -piet
>>
>>> Derek Atkins wrote:
>>>> Quoting Jason Wessel <jason.wessel@windriver.com>:
>>>>
>>>>>> Um, okay.....  How do I do that?  My GDB Fu is weak here; how do I
>>>>>> tell gdb that the symbols in vmlinux are all offset?  Or how do I
>>>>>> manipulate the vmlinux binary to offset the symbols?
>>>>>>
>>>>> Start gdb with no file.  And do something like:  add-symbol-file vmlinux
>>>>> 0xBFA00000
>>>> Um, where did you get "0xBFA0000" from?  Unfortunately this didn't
>>>> work at all.  I would think to get my numbers to work I'd need to
>>>> use 0xC0400000 to get sys_close to appear at 0xc047d341.  And
>>>> viola, that seems to work!  Or at least I got a reasonable breakpoint
>>>> from the 'target remote'
>>> 
>>> It was an example.  You had previously stated it was an offset of
>>> 0x600000 so it was a subtraction of 0x600000 from 0xc0000000.
>>> 
>>> Jaosn.
>>> 
>>> -------------------------------------------------------------------------
>>> This SF.net email is sponsored by: Microsoft
>>> Defy all challenges. Microsoft(R) Visual Studio 2005.
>>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>>> _______________________________________________
>>> Kgdb-bugreport mailing list
>>> Kgdb-bugreport@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
>>> 
>
>

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
