Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz1TH-0006Dq-MZ
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 09:23:02 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8BC793EE0BC
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 18:22:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7C33245DD6C
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 18:22:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B52C45DE55
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 18:22:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 38445E08001
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 18:22:32 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D30B51DB804B
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 18:22:31 +0900 (JST)
Message-ID: <51E510C9.1060200@jp.fujitsu.com>
Date: Tue, 16 Jul 2013 18:22:17 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: makedumpfile 1.5.4, 734G kdump tests
References: <20130709162403.GA25441@sgi.com>
 <20130711130647.GA20962@redhat.com> <20130712161427.GA13876@sgi.com>
 <20130712164202.GG2272@redhat.com>
In-Reply-To: <20130712164202.GG2272@redhat.com>
Content-Type: multipart/mixed; boundary="------------010309010606030907040107"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, Cliff Wickman <cpw@sgi.com>

This is a multi-part message in MIME format.
--------------010309010606030907040107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(2013/07/13 1:42), Vivek Goyal wrote:
> On Fri, Jul 12, 2013 at 11:14:27AM -0500, Cliff Wickman wrote:
>> On Thu, Jul 11, 2013 at 09:06:47AM -0400, Vivek Goyal wrote:
>>> On Tue, Jul 09, 2013 at 11:24:03AM -0500, Cliff Wickman wrote:
>>>
>>> [..]
>>>> UV2000   memory: 734G
>>>> makedumpfile: makedumpfile-1.5.4
>>>> kexec:   git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>>> booted with   crashkernel=1G,high crashkernel=192M,low
>>>> non-cyclic mode
>>>>
>>>> write to       option            init&scan sec.   copy sec.  dump size
>>>> -------------  -----------------           ----   ---------  ---------
>>>> megaraid disk  no compression                19          91      11.7G
>>>> megaraid disk  zlib compression              20         209       1.4G
>>>> megaraid disk  snappy compression            20          46       2.4G
>>>> megaraid disk  snappy compression no mmap    30          72       2.4G
>>>> /dev/null      no compression                19          28          -
>>>> /dev/null      zlib compression              19         206          -
>>>> /dev/null      snappy compression            19          41          -
>>>>
>>>> Notes and observations
>>>> - Snappy compression is a big win over zlib compression; over 4 times faster
>>>>    with a cost of relatively little disk space.
>>>
>>> Thanks for the results Cliff. If it is not too much of trouble, can you
>>> please also test with lzo compression on same configuration. I am
>>> curious to know how much better snappy performs as compared to lzo.
>>>
>>> Thanks
>>> Vivek
>>
>> Ok.  I repeated the tests and included LZO compression.
>>
>> UV2000   memory: 734G
>> makedumpfile: makedumpfile-1.5.4     non-cyclic mode
>> kexec: git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>> 3.10 kernel with vmcore mmap patches
>> booted with   crashkernel=1G,high crashkernel=192M,low
>>
>> write to       compression       init&scan sec.   copy sec.  dump size
>> -------------  -----------------           ----   ---------  ---------
>> megaraid disk  no compression                20          86      11.6G
>> megaraid disk  zlib compression              19         209       1.4G
>> megaraid disk  snappy compression            20          47       2.4G
>> megaraid disk  lzo compression               19          54       2.8G
>>
>> /dev/null      no compression                19          28          -
>> /dev/null      zlib compression              20         206          -
>> /dev/null      snappy compression            19          42          -
>> /dev/null      lzo compression               20          47          -
>>
>> Notes:
>> - Snappy compression is still be fastest (and more compressed than LZO),
>>    but LZO is close.
>> - Compression and I/O seem pretty well overlapped, so I am not sure that
>>    multithreading the crash kernel (to speed compression) will speed the
>>    dump as much I was hoping, unless perhaps the I/O device is an SSD.
>
> Thanks Cliff. So LZO is pretty close to snappy in this case.
>

This benchmarks lack considering randamized part ratio of data.
On my benchmark, LZO was slower than snappy from 50% to 100% randomized.

The attached is a graph of benchmark result that compares LZO and snappy
on a variety of ratio of randomized data. The benchmark detail is that

- block size is 4KiB
- sample data is 4MiB
   - so 4K blocks in total
- x value is percentage of amount of randomized data
- y value is performance of compression, i.e. 4MiB / (the time consumed for
   compressing the 4MiB sample data)
- processor is Xeon E7540
- randomizing data is done per a single byte. The 1-byte randomized data
   is chosen from /dev/urandom. Other part is filled with '\000'.

On this result, LZO remains 100 [MiB/sec] on data whose more than 50 percent
is randomized, while snappy shows better performance on more randomized
ratio.

On the worst case of this 100 [MiB/sec], 1TiB system memory needs about 3
hours to take crash dump.

While I don't think it's typical case, it's problematic that crash dump
requires some more hours depending on contents of memory at crash time.
It should always complete in as stable time as possible.

-- 
Thanks.
HATAYAMA, Daisuke

--------------010309010606030907040107
Content-Type: image/png;
 name="xen_e7540-performance.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xen_e7540-performance.png"

iVBORw0KGgoAAAANSUhEUgAAAcUAAAEhCAIAAACBdixHAAAAAXNSR0IArs4c6QAAAARnQU1B
AACxjwv8YQUAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAA
LudJREFUeF7tnQm3FsWZx51Pka804XqR9YJA3NGocWIgiftl83CVRI0aD8IVdDRoUCMGF+Au
bCG4wJhoUKIJMXFJlBjNGBKHcTzM877VXV3dXd1d3bV0dfWf857k2m911VP/qv69Ty391L9t
27bt448/Pg//oAAUgAJQQEOBr33ta+dt3LjxHP5BASgABaCAngLEUvBUT0LcDQWgABQYKgCe
oiNAASgABcwoAJ6a0RG5QAEoAAXAU/QBKAAFoIAZBcBTMzoiFygABaAAeIo+AAWgABQwowB4
akZH5AIFoAAUAE/RB6AAFIACZhQAT83oiFygABSAAuAp+gAUgAJQwIwC4KkZHZELFIACUAA8
RR+AAlAACphRADw1oyNygQJQAAqAp+gDUAAKQAEzCoCnZnRELlAACkAB8BR9AAqUKXB6alUS
X3jyBMSCAiUKgKel3SN5mFZNnU6lPDEZPWXZL9rqbqnnPhVhPLaQmyyNPx6nKsxHXtFU8nyS
TJmmxCow0jzuLNnfVidBuZYVAE/LBRYeXPFhLeas5fYqzr6YlvV4WpiPlIXp1OkkBTmZYGrJ
T4OJ7GOVk2Y2T+rWOgoKtqgAeFolrgyd3jmnVIlmNuXviq+ocClKOzkZOeviPbmcTf4GSSor
INYY/LjJxnKs6m34vtsKgKfV7Zc8qYwXfnotjXjKb0qAoc7TSAcSJX8P16gUsdXaF6SQVjZp
J1P4k8jT2GTc2AcFwFOFVk4P+svApTLdlpv7y3iC8fcDKFTMToq2N+Cp9IdBmaexc0pm5u+R
k8gYn6SVLfqdK20UQe3Ub4B0RiHF6RrtmP11KWziuAAxb8lAIT99nP4FqdeFyuZshHEPm3VX
GbYoPFKhJgFPlVpWsv6R61gq04WF835CbnFZq1YJC8vVi1/1eSq/Q5Gn4iOb56nUPRV+HnSf
SmWeVjaKTO2BdeU8bdqOUb1Lm7ii2VXWC5W7kDwzDudK9ZQenj4lAk8VWzvbtTJDSglA8s6Y
hAJJthwxMt9EYShb9IgXjn0LACzNJ8s//sCyXQ85BhfkXYBZxSYQksnyz8/PqjSKjCi8tgX+
dP12jHdUZHgqOHxpO6JGkzX7MKHYHpJaKnahvGKsKVnpKurVb7nA7wBPVRs4zZkinEo3ART2
T2m3lUKnmkQ1eZo8S0VVye6qEp7huKz4Vg94KiAkN2guaZTUjErup0fKU1XfW4Ra9a+vMLAW
Elc3uwg+fqNaFyrPnH9bpp7qw9ObdOCpWlPn3BilrUGpUXqBs5OMLKOOq/Yw5MyuN95XcHij
EgROZ0erfEuuIZ7mfxKKnOvC8XbsXIles3S7bezilUJF2mRa7chElRYqy7fIOnn9a/K0qCLM
xhKJMY1aCA3wVIWngjMXbw1KjbkK57TYozzs54UPbrZbO+CpbKBXrEOGvVnnVDbeV/Xh0oXq
8lS+KCPHaTSoLW6WFFNUXEaldtTnaUlfq8dTRfdULp+pHRQqT1+X0oCnCq2Vcv0kA8vyhzIu
QMuvqR741fBP6+E0sz+s4reD/XwUzCaUe0QKLZHTsmRhq1qyQlextMm02lGbp5Jmzo/MlX6S
C2d8il3oGi3U06TgaWXD54bGEhypwKzg+c7dqvQw5K1WMSE7klPzMtI5K/FUfURbKb80gVJl
lRLVH+9rtaMuT2Wzmg15WvEGiJJ6zVov4LvA04rGlfpyCWLzb72nPKbh3flNhUkayTymZZ7K
/OtEg8G3+RpUbT3MzZ/KXnoo94fqPWNqD3uBHy5vFJmnK3dFZdmqtqMxnvJeJUyS1Bvvi1Ok
SeUHlcusn0o6hNoPcb02DSI1eFrejJLnJDVKlNEyO+OUdL5i365qgq568FqyfiBdoZXvzFay
MCeZhKeZdxESTXS3ng4LV+NpoQ3xnDblVN8/FW/KTS5WtaMuT0vXierytCizvJNQ3KWDoKC5
SoCnZVqWuFR5F1X2nKm821K0t7Nqk2HG8JJxuPCQS82uyqnSG5HyNPO7Y/TlGlWeSmzIvOLT
iKfV2ZaTWlqozBmWW5du6skT8X/X52nqt0k6Csl1KyO/h+YA5llO4KlnDQJzoAAU6KwC4Gln
mw6GQwEo4JkC4KlnDQJzoAAU6KwC4Glnmw6GQwEo4JkC4KlnDQJzoAAU6KwC4Glnmw6GQwEo
4JkC4KlnDQJzoAAU6KwC4Glnmw6GQwEo4JkC4KlnDQJzoAAU6KwC4Glnmw6GQwEo4JkC4Kln
DQJzoAAU6KwC4Glnmw6GQwEo4JkC4KlnDQJzoAAU6KwC4Glnmw6GQwEo4JkC4KlnDQJzoAAU
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
lEUXhxnVw6nB+FJ19kslaYV4fPF7VelXq5qed8K6AK1jsEa9ZPXjazCF2uS5aOceDPbb0d1V
qQbmT4dk4OP9wbifOagMKSkHk4/X1Xka5VQTpwZ5WqMlTkwmUaRF99tkfClmDj8b4zvXb7lg
w/7nX3mvhplI2p4CGOy3p72Lkg3wNIGnzD/l11LrOsLQfvAnw5D0Ist9cjKZK1CSxdx4f2i3
6G4qlC//EeE/LtJDUCqz5fOnlHJq/Q+Zf3rrNXddsG526Z2HgNRKAX1IgMG+D61gz4ZDC+dL
ZwPoemWhuZhz0vE+TzU5mZxSp7oeFfu6tYlmjqdsuK62EJbUNXLTM9MUSagqxfj8dGADPzqC
nXdC/65bP7nm6gnWbJtWriGeDj5r99J1nhh/eKjApg0bZkbnsIb7wdq1HloYmEm9Oe8ku5I1
5Kb0YukXxcg3zdMoUl9q60Jx6Ykvnp6nqM1TsQjmn96w/djYxgM0zGeP5UMrrot4um6WrtO3
lT+DSNCWAtjG35byoZdbh6e19knFwpnjaZ31qKTZ4hF/bmive94JFbFux6+/eeNPGU93Lr6Y
8XTRhv10PfR+06X6lRwVdXjpki7VBLb2XgFzPFWX8sRkaj8YmyIQdo4lf0ovVhUkzp9uePQY
4ylFlSaYjo5PA6ZV+rn+vmhpgjZ7d/3tQ9dSory2FWiDp+KL/sL8aG6aOcZszWj/Ik8pi72L
FjOkLr3pWdrVj0BTbXe5bPngqW8tAnsaK2CUp+KQv+ZKf+MK5G/M8JRvQb1i1aPE05/sP2Ww
LGSlrwB4qq8hcvBEAYM8zU2gqq31Gxciw9M374yW+L9z3f3E0xsfPm68RGSoowB4qqMe7vVK
AXM8Te2bZUP6doDKeFqyynHkssu8aoOeGwOe9rwDhFT9YHmKp7Qr3RQt1ZWWgp2VCpjjqS/h
pAev0FK18ZRWtr0nCdBSnjQEzNBXwABPhViB4hRqO4N9UkSFp8ff+URfO+RgRAHw1IiMyMQH
BfR5Gu8RlYUebKWGKjy986nftGIbCs0rgKOi0CuCUUCfp0KYvdTLpsov85vWUoWn89bPIry0
aeGb50fh93ko/tNHjzbPCHdCgVYVMMDT/MRpzNV2hvwqPKWNU1v3vH33rjdbFR+FRwrwPW04
dw99otMKmOApE6BT433i6dy10wvWIyKq095bsoltduTrNJH6j1N428Jpi6AwswqY5Wnd+Kdm
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
--------------010309010606030907040107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------010309010606030907040107--


